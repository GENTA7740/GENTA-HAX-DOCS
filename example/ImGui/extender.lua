local g_StateEnum = {
    GHOST_MODE = 1,
    FAST_DICE = 2,
    ANTI_CHECKPOINT = 3,
    ANTI_TAKE_ITEM = 4,
}

local g_StateName = {
    "Ghost mode",
    "Fast Dice",
    "Anti Checkpoint",
    "Anti Take Item",
}

local g_States = { false, false, false, false }

function fHookOnRaw(raw)
    local packetHandlers = {
        [0] = function() 
            if g_States[GHOST_MODE] then
                return true
            end
        end,
        [7] = function()
            if g_States[ANTI_CHECKPOINT] then
                return true
            end
        end,
        [11] = function()
            if g_States[ANTI_TAKE_ITEM] then
                return true
            end
        end,
        [25] = function()
            logToConsole("[BAN BYPASS] Auto ban packet have been blocked!")
            return;
        end,
    }

    local handler = packetHandlers[raw.type]
    if handler then
        handler()
    end
  return false
end
function fHookOnGameUpdatePacket(raw)
    local packetHandlers = {
        [8] = function()
            if g_States[FAST_DICE] then
                if raw.value == 0 then
                    logToConsole("Dice will roll: "..(raw.padding3 + 1))
                end
            end
        end,
    }

    local handler = packetHandlers[raw.type]
    if handler then
        handler()
    end
    return false
end

function fRenderHook(deltaTime)
    ImGui.Begin("GSCRIPT")

    for i = 1, 4 do
        local changed, value = ImGui.Checkbox("Checkbox " .. i, checkboxes[i])
        if changed then
            checkboxes[i] = value
        end
    end

    ImGui.End()
end

AddHook("onrawpacket", "LABEL_01", fHookOnRaw)
AddHook("ongameupdatepacket", "LABEL_02", fHookOnGameUpdatePacket)
AddHook("OnRender", "LABEL_03", fRenderHook)
