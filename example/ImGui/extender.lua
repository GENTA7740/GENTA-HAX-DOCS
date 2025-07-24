local g_StateEnum = {
    GHOST_MODE = 1,
    FAST_DICE = 2,
    ANTI_CHECKPOINT = 3,
    ANTI_TAKE_ITEM = 4,
    SKIP_UPDATE = 5,
}

local g_StateName = {
    "Ghost mode",
    "Fast Dice",
    "Anti Checkpoint",
    "Anti Take Item",
    "Skip update",
}

local g_TabNames = {
    "\xef\x80\x93",
    "\xef\x82\x85",
}

local g_AutoEnum = {
    PUT_AND_BREAK = 1,
    AUTO_COLLECT = 2,
    AUTO_DROP = 3,
}
local g_AutoName = {
    "PNB",
    "Collect",
    "Drop",
}
local g_States = { false, false, false, false, false }
local g_CurrentMainTab = 1
local g_CurrentAutoTab = 1
local g_AutoCollectState = false
-- COLLECT CLASS, I'll clean it later --
AutoCollect = {}
AutoCollect.__index = AutoCollect

function AutoCollect:new()
    local self = setmetatable({}, AutoCollect)
    self.is_active = false
    self.range = 3
    self.delay = 180
    self.lastTime = 0
    return self
end

function AutoCollect:currentTimeMillis()
    return getCurrentTimeInternal()
end

function AutoCollect:shouldRun()
    if not self.is_active then return false end
    local now = self:currentTimeMillis()
    if now - self.lastTime >= self.delay then
        self.lastTime = now
        return true
    end
    return false
end

function AutoCollect:run()
    if self:shouldRun() then
        runThread(function()
            requestCollectByRange(self.range)
        end)
    end
end

-- END

g_Collect = AutoCollect:new()

function fHookOnRaw(raw)
    local packetHandlers = {
        [0] = function() 
            if g_States[g_StateEnum.GHOST_MODE] then
                return true
            end
        end,
        [7] = function()
            if g_States[g_StateEnum.ANTI_CHECKPOINT] then
                return true
            end
        end,
        [11] = function()
            if g_States[g_StateEnum.ANTI_TAKE_ITEM] then
                return true
            end
        end,
        [24] = function()
            sendPacket(2, "action|enter_game\n")
            logToConsole("Skipping update...")
        end,
        [25] = function()
            logToConsole("[`"..math.random(1, 9).."BAN BYPASS``] Auto ban packet have been blocked!")
            return true
        end,
    }

    local handler = packetHandlers[raw.type]
    if handler then
        return handler() or false
    end
  return false
end
function fHookOnGameUpdatePacket(raw)
    local packetHandlers = {
        [8] = function()
            if g_States[g_StateEnum.FAST_DICE] then
                if raw.value == 0 then
                    logToConsole("Dice will roll: "..(raw.padding3 + 1))
                end
            end
        end,
    }

    local handler = packetHandlers[raw.type]
    if handler then
        return handler() or false
    end
    return false
end

-- MENU --
function fCheatsMenu(deltaTime)
    ImGui.BeginGroupPanel("CHEATS", ImVec2(ImGui.GetContentRegionAvailWidth(), 0))
        if ImGui.BeginTable("##table_0", 3) then
            for i = 1, #g_StateName do
                ImGui.TableNextColumn()
                local changed, value = ImGui.Checkbox(g_StateName[i], g_States[i])
                if changed then
                    g_States[i] = value
                end
            end
            ImGui.EndTable()
        end

    ImGui.EndGroupPanel()
end

function fAutomationsMenu(deltaTime)

    if ImGui.BeginChild("MY_AUTO_1", ImVec2(ImGui.GetContentRegionAvailWidth() * 0.222, 0)) then
        for i = 1, #g_AutoName do
            if ImGui.ButtonWithStripe(g_AutoName[i], (g_CurrentAutoTab == i), ImGui.GetContentRegionAvailWidth()) then
                g_CurrentAutoTab = i
            end
        end
    end
    ImGui.EndChild()
    ImGui.SameLine()
    if ImGui.BeginChild("MY_AUTO_2", ImVec2(ImGui.GetContentRegionAvailWidth(), 0), true) then
        local menuCases = {
                [1] = function()
                end,
                [2] = function()
                    local changed, value = ImGui.Checkbox("Toggle", g_AutoCollectState)
                    if changed then
                        g_AutoCollectState = value
                        g_Collect.is_active = g_AutoCollectState;
                    end

                    local range = g_Collect.range
                    local delay = g_Collect.delay

                    local changed1, newRange = ImGui.SliderInt("Range", range, 1, 10)
                    if changed1 then g_Collect.range = newRange end

                    local changed2, newDelay = ImGui.SliderInt("Delay", delay, 180, 1000)
                    if changed2 then g_Collect.delay = newDelay end
                end,
        }

        local handler = menuCases[g_CurrentAutoTab]
        if handler then
            handler(deltaTime)
        end
    end
    ImGui.EndChild()
end

-- END MENU --

function fEventLoop()
    g_Collect:run()
end

function fRenderHook(deltaTime)
    if ImGui.Begin("GENTAHAX - Extender") then
        if ImGui.BeginChild("MY_MAIN_CHILD_01", ImVec2(ImGui.GetContentRegionAvailWidth() / 10.0, 0), false) then
            for i = 1, #g_TabNames do
                if ImGui.ButtonWithStripe(g_TabNames[i], (g_CurrentMainTab == i), ImGui.GetContentRegionAvailWidth()) then
                    g_CurrentMainTab = i
                end
            end
        end
        ImGui.EndChild()
        ImGui.SameLine()
        if ImGui.BeginChild("MY_MAIN_CHILD_02", ImVec2(ImGui.GetContentRegionAvailWidth(), 0)) then
            local menuCases = {
                [1] = fCheatsMenu,
                [2] = fAutomationsMenu,
            }

            local handler = menuCases[g_CurrentMainTab]
            if handler then
                handler(deltaTime)
            end
        end
        ImGui.EndChild()
    end
    ImGui.End()
    fEventLoop()
end

AddHook("OnRender", "LABEL_01", fRenderHook)
AddHook("onrawpacket", "LABEL_02", fHookOnRaw)
AddHook("ongameupdatepacket", "LABEL_03", fHookOnGameUpdatePacket)
