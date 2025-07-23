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

local g_States = { false, false, false, false }

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
                logToConsole("TAKEND?")
                return false
            end
        end,
        [24] = function()
            sendPacket(2, "action|enter_game\n")
            logToConsole("Skipping update...")
        end,
        [25] = function()
            logToConsole("[BAN BYPASS] Auto ban packet have been blocked!")
            return true;
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

function fRenderHook(deltaTime)
    ImGui.Begin("GSCRIPT")

    ImGui.BeginGroupPanel("CHEATS", ImVec2(ImGui.GetContentRegionAvailWidth(), 0))
        if ImGui.BeginTable("##table_0", 3) then
            for i = 1, 5 do
                ImGui.TableNextColumn()

                local changed, value = ImGui.Checkbox(g_StateName[i], g_States[i])
                if changed then
                    g_States[i] = value
                end
            end
            ImGui.EndTable()
        end

    ImGui.EndGroupPanel()

    ImGui.End()
end

AddHook("OnRender", "LABEL_01", fRenderHook)
AddHook("onrawpacket", "LABEL_02", fHookOnRaw)
AddHook("ongameupdatepacket", "LABEL_03", fHookOnGameUpdatePacket)
