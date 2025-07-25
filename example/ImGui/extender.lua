local g_StateEnum = {
    GHOST_MODE = 1,
    FAST_DICE = 2,
    ANTI_CHECKPOINT = 3,
    ANTI_TAKE_ITEM = 4,
    SKIP_UPDATE = 5,
    BLOCK_SDB = 6,
    BLOCK_SB = 7,
}

local g_StateName = {
    "Ghost mode",
    "Fast Dice",
    "Anti Checkpoint",
    "Anti Take Item",
    "Skip update",
    "Block SDB",
    "Block SB",
}
local g_EspEnum = {
    NPC_ESP = 1,
    PLAYER_ESP = 2,
}

local g_EspName = {
    "NPC ESP",
    "Player ESP"
}

local g_TabNames = {
    "\xef\x80\x93",
    "\xef\x82\x85",
    "\xef\x80\x82",
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
local g_EspStates = { false, false }
local g_States = { false, false, false, false, false, false, false }
local g_CurrentMainTab = 1
local g_CurrentAutoTab = 1
local g_AutoCollectState = false
local g_CustomName = ""
-- COLLECT CLASS, I'll clean it later --
AutoCollect = {}
AutoCollect.__index = AutoCollect
local RED_U32 = ImGui.ColorConvertFloat4ToU32(ImVec4(1.0, 0.0, 0.0, 1.0))
local WHITE_U32 = ImGui.ColorConvertFloat4ToU32(ImVec4(1.0, 1.0, 1.0, 0.0))
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
            if g_States[g_StateEnum.SKIP_UPDATE] then
                sendPacket(2, "action|enter_game\n")
                logToConsole("Skipping update...")
            end
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
        if ImGui.BeginTable("##table_1", 3) then
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
    ImGui.BeginGroupPanel("ESP", ImVec2(ImGui.GetContentRegionAvailWidth(), 0))
        if ImGui.BeginTable("##table_2", 2) then
            for i = 1, #g_EspName do
                ImGui.TableNextColumn()
                local onChanges, value = ImGui.Checkbox(g_EspName[i], g_EspStates[i])
                if onChanges then
                    g_EspStates[i] = value
                end
            end
            ImGui.EndTable()
        end

    ImGui.EndGroupPanel()
    ImGui.SetNextItemWidth(ImGui.GetContentRegionAvailWidth())
    local changed, newText = ImGui.InputTextWithHint("##SET-VISUAL-NAME", "Visual name...", g_CustomName, 128)
    if changed then
        g_CustomName = newText
        sendVariant({
            [0] = "OnNameChanged",
            [1] = "``"..g_CustomName.."``",
        }, getLocal().netId)
    end
    
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
                    local changed, value = ImGui.Checkbox("Toggle", g_Collect.is_active)
                    if changed then
                        g_Collect.is_active = value
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
function fNpcEsp()
    if g_EspStates[g_EspEnum.NPC_ESP] then
        local p_local = getLocal()
        if type(p_local) == "table" then
            local _p = worldToScreen(p_local.pos.x, p_local.pos.y);
            local npc_table = getNpc()
            if type(npc_table) == "table" then
                for _, v in pairs(npc_table) do
                    if v and v.current and v.current.x and v.current.y then
                        local _start = worldToScreen(v.current.x - 16, v.current.y - 16)
                        local _end = worldToScreen(v.current.x + 16, v.current.y + 16)
                        ImGui.BG:AddRect(_start, _end, 0xFF2CFF00, 0.0, 1.0)
                        ImGui.BG:AddLine(_p, _start, 0xFF2CFF00, 1.0)
                    end
                end
            end
        end
    end
end
function fPlayerEsp()
    if g_EspStates[g_EspEnum.PLAYER_ESP] then
        local p_local = getLocal()
        if type(p_local) == "table" then
            local _p = worldToScreen(p_local.pos.x, p_local.pos.y);
            local players_table = getPlayerlist()
            if type(players_table) == "table" then
                for _, v in pairs(players_table) do
                    if v ~= nil then
                        local _start = worldToScreen(v.pos.x - 8, v.pos.y - 8);
                        local _end = worldToScreen((v.pos.x + 20 ) + 5, (v.pos.y + 30) + 5);
                        ImGui.BG:AddRect(_start, _end, 0xFFFFFFFF, 0.0, 1.0);
                        ImGui.BG:AddLine(_p, _start, 0xFFFFFFFF, 1.0);
                    end
                end
            end
        end
    end
end
function fEventLoop()
    g_Collect:run()
    fNpcEsp()
    fPlayerEsp()
end

function fRenderHook(deltaTime)
    ImGui.SetNextWindowSize(ImVec2(600, 400), ImGui.Cond.Once)
    if ImGui.Begin("GENTAHAX - Extender") then
        if ImGui.BeginChild("MY_MAIN_CHILD_01", ImVec2(ImGui.GetContentRegionAvailWidth() / 10.0, 0), false) then
            for i = 1, #g_TabNames do
                
                ImGui.PushStyleColor(
                    ImGui.Col.Button,
                    (g_CurrentMainTab == i) and RED_U32 or WHITE_U32
                )
                if ImGui.ButtonWithStripe(g_TabNames[i], (g_CurrentMainTab == i), ImGui.GetContentRegionAvailWidth()) then
                    g_CurrentMainTab = i
                end
                ImGui.PopStyleColor(1)
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
    collectgarbage("collect")
	collectgarbage("setstepmul", 30)
end
function fOnVarlist(vlist, netid)
    local varCase = {
        [hash32("OnSDBroadcast")] = function()
            logToConsole("[`4ANTI SDB``] Super duper broadcast have been blocked!")
            return true
        end,
        [hash32("OnConsoleMessage")] = function()
            if vlist[1]:match("CP:0_PL:4_OID:_CT:%[SB%]_") and g_States[g_StateEnum.BLOCK_SB] then
                return true
            end
        end,
    }

    local handler = varCase[hash32(vlist[0])]
    if handler then
        return handler() or false
    end
  return false
end


function fOntextPacket(type, pkt)
    local warpTarget = pkt:lower():match("/warp%s+(%S+)")
    if warpTarget then
        sendPacket(3, "action|join_request\nname|"..warpTarget:upper().."\ninvitedWorld|0\n")
        logToConsole("`"..math.random(1, 9).."Warping to``: `w"..warpTarget:upper().."``")
        return true
    end
    local bscan_det = pkt:lower():match("/warp%s+(%S+)")
    if bscan_det then
        sendPacket(3, "action|join_request\nname|"..warpTarget:upper().."\ninvitedWorld|0\n")
        logToConsole("`"..math.random(1, 9).."Warping to``: `w"..warpTarget:upper().."``")
        return true
    end
    local fscan_det = pkt:lower():match("/bscan")
    if fscan_det then
        local _dmp = ""
        local _nmap = {}

        for _, tile in pairs(getTile()) do
            if tile then
                if tile.fg and tile.fg ~= 0 then
                    if _nmap[tile.fg] == nil then
                        _nmap[tile.fg] = 1
                    else
                        _nmap[tile.fg] = _nmap[tile.fg] + 1
                    end
                end

                if tile.bg and tile.bg ~= 0 then
                    if _nmap[tile.bg] == nil then
                        _nmap[tile.bg] = 1
                    else
                        _nmap[tile.bg] = _nmap[tile.bg] + 1
                    end
                end
            end
        end

        for itemID, count in pairs(_nmap) do
            _dmp = _dmp .. tostring(itemID) .. "," .. tostring(count) .. ","
        end

        local dlgd =
            "add_label_with_icon|big|World Blocks.|left|6016|\n" ..
            "add_spacer|small\n" ..
            "add_label_with_icon_button_list|small|`w%s : %s|left|blockScan_|itemID_itemAmount|" ..
            _dmp ..
            "\nadd_spacer|small|\n" ..
            "end_dialog|gscan_block|Exit||\n" ..
            "add_quick_exit|\n"

        local var = {}
        var[0] = "OnDialogRequest"
        var[1] = dlgd
        sendVariant(var, -1, 100)


        return true
    end
    return false
end
AddHook("onvarlist", "LABEL_01", fOnVarlist)
AddHook("OnRender", "LABEL_02", fRenderHook)
AddHook("onrawpacket", "LABEL_03", fHookOnRaw)
AddHook("ongameupdatepacket", "LABEL_04", fHookOnGameUpdatePacket)
AddHook("ontextpacket", "LABEL_05", fOntextPacket)
