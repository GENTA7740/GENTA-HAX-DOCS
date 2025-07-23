local checkboxes = { false, false, false, false }

function imDemo(deltaTime)
    ImGui.Begin("GSCRIPT")

    for i = 1, 4 do
        local changed, value = ImGui.Checkbox("Checkbox " .. i, checkboxes[i])
        if changed then
            checkboxes[i] = value
        end
    end

    ImGui.End()
end

AddHook("OnRender", "LABEL_01", imDemo)
