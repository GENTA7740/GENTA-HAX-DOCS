-- imgui demo script
-- Genta 7740 - 2024/03/22

-- It is suggested to look at the window created by this script while reading this.


-- imgui widgets have no state, that means we need to store
-- states of checkboxes, radio buttons etc. globally
makeRed = false
sliderVal = 0
choice = 1
angle = 0
text = ""
text2 = "/*\n The Pentium F00F bug, shorthand for F0 0F C7 C8,\nthe hexadecimal encoding of one offending instruction,\n more formally, the invalid operand with locked CMPXCHG8B\n instruction bug, is a design flaw in the majority of\n Intel Pentium, Pentium MMX, and Pentium OverDrive\n processors (all in the P5 microarchitecture).\n */\n"
text3 = ""

function imDemo(deltaTime)
	ImGui.Begin("ImLua")
    -- This function is called for every frame. Use this function to create your GUI.n
    -- so you know which of these windows is currently being built.

    -- If you additionally need the current width and height of the window, use these functions:
    local win_width = ImGui.GetWindowWidth()
    local win_height = ImGui.GetWindowHeight()
    -- These function return the window's width and height in boxels.

    -- The easiest thing we can do in imgui is drawing text. The function is called TextUnformatted because
    -- it doesn't support C-style format strings. imgui has a function called Text() that does support these
    -- format strings, but it is not supported in lua.
    ImGui.TextUnformatted("Hello, World! Imgui 1.82 demo for GENTA HAX")
	ImGui.Text("Delta Time: "..deltaTime)
    -- Since TextUnformatted does not support format strings, you can use lua to create a string on the fly:
    ImGui.TextUnformatted("Window size: " .. win_width .. ", " .. win_height)

    -- imgui automatically arranges all widgets from top to bottom, so the following text is drawn below:
    ImGui.TextUnformatted("Two Widgets")
    -- It is possible to put a widget on the same line, i.e. avoiding the automatic line feed:
    ImGui.SameLine()
    ImGui.TextUnformatted("One Line.")
    -- BeginGroupPanel will show a line border with a title between the lines.
    ImGui.BeginGroupPanel("Something?!", ImVec2(ImGui.GetContentRegionAvailWidth(), 0))
    ImGui.TextUnformatted("Something goes here!?")
    ImGui.EndGroupPanel();
    -- To maintain a tidy layout, let's show the next windows grouped in tree nodes.
    -- The user can collapse or expand these nodes to show or hide the content.
    -- It is not required to put widgets into tree nodes, this is just an example.
    if ImGui.TreeNode("Styling Widgets") then
        -- The TreeNode function creates such a tree node. The parameter is the label of the node.
        -- The function returns true if the node is currently opened, so the if statement takes care
        -- that the contained widgets are only drawn if the node is currently expanded.

        -- It is possible to place widgets at arbitrary coordinates by manipulating the draw cursor's position.
        -- Let's center a text horizontally by first measuring its size and then putting it at the center of the line:
        
        -- CalcTextSize returns the width and height of a text in boxels without drawing it.
        -- GetCursorPosX and GetCursorPosY return the position where the next widget will be placed.
        -- SetCursorPos can be used to manipulate this position.
        -- imgui's coordinates have the origin in the upper left and the axes grow to the right and to the bottom.

        -- The following function changes the color of all widgets until PopStyleColor is called.
        -- The format is AABBGGRR where A is alpha and B, G and R are blue, green and red.
        -- So if you have an HTML color like #2B65EC (ocean blue), swap the first two and last two hex digits
        -- and prefix it with FF to use it:
        ImGui.PushStyleColor(ImGui.Col.Text, 0xFFEC652B)
        ImGui.TextUnformatted("Ocean Blue Text")
        ImGui.TextUnformatted("Also Ocean Blue")
        -- In this example we changed the value of ImGui.Col.Text which is the foreground text
        -- color. For other supported style colors that can be changed, see footnote [1] below.
        
        -- Restore the previous style, this _must_ be called after each pushed style:
        ImGui.PopStyleColor()

        ImGui.TextUnformatted("No longer Ocean Blue")

        -- This function must be called at the end of every tree node to tell imgui that the code after
        -- it is not part of the TreeNode anymore.
        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("Buttons") then
        -- The following function creates a button:
        if ImGui.Button("Push Me") then
            -- The Button function creates a button with the given label. It returns true in the
            -- moment where the button is released, i.e. the if statement is used to check whether
            -- the action behind the button should now be executed. Let's make the button toggle a variable:
            makeRed = not makeRed
        end
        
        -- Use the variable to change the color of the text
        if makeRed then
            ImGui.PushStyleColor(ImGui.Col.Text, 0xFF0000FF)
        else
            ImGui.PushStyleColor(ImGui.Col.Text, 0xFF00FF00)
        end

        ImGui.TextUnformatted("Some Text")
        ImGui.PopStyleColor()
        
        -- If you want to trigger the action while the button is clicked and not only when it is released:
        ImGui.Button("Click and hold")
        if ImGui.IsItemActive() then
            makeRed = not makeRed
        end
        
        -- Control the size of a button 
        if ImGui.Button("Button 1", 65, 25) then
        
        end
        -- Keep the next button on the same line.
        ImGui.SameLine()
        -- Control position of next button
        ImGui.SetCursorPosX(150)
        
        if ImGui.Button("Button 2", 65, 25) then
        
        end
        ImGui.SameLine()
        ImGui.SetCursorPosX(150 * 2)
        
        if ImGui.Button("Button 3", 65, 25) then
        
        end
        
        -- Radio buttons: Specify whether the choice is currently active as parameter.
        -- Returns true when the choice is selected.
        if ImGui.RadioButton("Choice 1", choice == 1) then
            choice = 1
        end
        if ImGui.RadioButton("Choice 2", choice == 2) then
            choice = 2
        end
        if ImGui.RadioButton("Choice 3", choice == 3) then
            choice = 3
        end
        
        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("Checkboxes") then
        -- The following function creates a checkbox:
        local changed, newVal = ImGui.Checkbox("Make text red", makeRed)
        -- The first parameter is the caption of the checkbox, it will be displayed right of the checkbox.
        -- The second parameter is the current boolean value.
        
        -- The function returns two values: a bool to indicate whether the value was changed and the new value. 
        if changed then
            makeRed = newVal
        end

        if makeRed then
            ImGui.PushStyleColor(ImGui.Col.Text, 0xFF0000FF)
        else
            ImGui.PushStyleColor(ImGui.Col.Text, 0xFF00FF00)
        end

        ImGui.TextUnformatted("Some Text")
        ImGui.PopStyleColor()
        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("Sliders") then
        -- The following function creates a slider:
        local changed, newVal = ImGui.SliderFloat("Slider Caption", sliderVal, 0, 100000, "Value: %.2f")
        -- The first parameter is the caption of the slider, it will be displayed right of the slider.
        -- The second parameter is the current position. Pass the variable that should be changed by the slider.
        -- The third and fourth parameter specify the range of the slider, i.e. the min and max value.
        -- The fourth parameter is a format string to show on the slider. Must contain a variant of "%f" in the text.
        -- The example format string rounds the value to two decimal places and prefixes the value with "Value: " on the slider.
        
        -- The function returns two values: a bool to indicate whether the value was changed and the new value. You must copy
        -- the new value into the slider variable if the value changed:
        if changed then
            sliderVal = newVal
        end

        -- Additionally, it is possible to create a non-linear slider by specifying the power of the slider:
        local changed, newVal = ImGui.SliderFloat("Power Slider", sliderVal, 0, 100000, "Value: %.2f", 3.0)
        if changed then
            sliderVal = newVal
        end
        
        -- For non-decimals:
        local changed, newVal = ImGui.SliderInt("Int Slider", sliderVal, 0, 100000, "Value: %.0f")
        if changed then
            sliderVal = newVal
        end
        
        -- For angles: 
        local changed, newVal = ImGui.SliderAngle("Angle Slider", angle, -180, 180, "Value: %.0f")
        if changed then
            angle = newVal
        end

        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("ComboBox") then
    
        local choices = {"Choice 1", "Choice 2", "Choice 3"}

        -- BeginCombo starts a combo box. The first parameter is the label, the
        -- second parameter the text of the currently selected choice.
        if ImGui.BeginCombo("Combo Box", choices[choice]) then
            -- Loop over all choices
            for i = 1, #choices do
                -- The Selectable function adds a choice to a combobox.
                -- The first parameter is the label, the second one
                -- should be true if this choice is currently selected.
                if ImGui.Selectable(choices[i], choice == i) then
                    -- Selectable returns true when a new choice was selected,
                    -- we should then copy the choice into our choice variable
                    choice = i
                end
            end
            -- _Must_ be called if and only if BeginCombo returns true, i.e.
            -- when the combobox is currently open
            ImGui.EndCombo()
        end
        
        -- Here is an easier example to understand the loop above
        if ImGui.BeginCombo("Combo Box 2", "") then
            if ImGui.Selectable("Choice A", choice == 1) then
                choice = 1
            end
            if ImGui.Selectable("Choice B", choice == 2) then
                choice = 2
            end
            if ImGui.Selectable("Choice C", choice == 3) then
                choice = 3
            end
            ImGui.EndCombo()
        end
        
    
        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("Drag Controls") then
        -- These are somewhat similar to sliders but you can drag them multiple 
        -- times at the same position to continously increase or decrease the value
        local changed, newVal = ImGui.DragFloat("Drag Float", sliderVal, 1.0, 0, 1000, "%.2f", 1.0)
        -- Parameters: Label, value, speed, min, max, caption, power
        
        if changed then
            sliderVal = newVal
        end

        local changed, newVal = ImGui.DragInt("Drag Int", sliderVal, 1.0, 0, 1000, "%.2f", 1.0)
        if changed then
            sliderVal = newVal
        end
        
        ImGui.TreePop()
    end
    
    
    if ImGui.TreeNode("Input") then
        -- Allow the user to input text
        local changed, newText = ImGui.InputText("One Line Text", text, 255)
        -- Parameters: Label, current text, maximum number of allowed characters

        if changed then
            text = newText
        end

        local changed, newText2 = ImGui.InputTextMultiline("Multiline Text", text2, 500)
        -- Parameters: Label, current text, maximum number of allowed characters

        if changed then
            text2 = newText2
        end

        local changed, newText3 = ImGui.InputTextWithHint("Text With a Hint", "hint", text3, 255)
        -- Parameters: Label, current text, maximum number of allowed characters

        if changed then
            text3 = newText3
        end
        
        -- Allow the user to input an integer, either using the keyboard or by clicking + / -
        local changed, newInt = ImGui.InputInt("Input int", sliderVal)
        if changed then
            sliderVal = newInt
        end
        
        -- The +/- steps can optionally be changed:
        local changed, newInt = ImGui.InputInt("Input int2", sliderVal, 10)
        if changed then
            sliderVal = newInt
        end

        ImGui.TreePop()
    end
    
    
    if ImGui.TreeNode("ListBox") then
        local choices = {"Choice 1", "Choice 2", "Choice 3"}
        
        -- BeginListBox starts a list box. The first parameter is the label, the
        -- second parameter the text of the currently selected choice.
        if ImGui.BeginListBox("List Box", choices[choice]) then
            -- Loop over all choices
            for i = 1, #choices do
                -- The Selectable function adds a choice to a listbox.
                -- The first parameter is the label, the second one
                -- should be true if this choice is currently selected.
                if ImGui.Selectable(choices[i], choice == i) then
                    -- Selectable returns true when a new choice was selected,
                    -- we should then copy the choice into our choice variable
                    choice = i
                end
            end
            -- _Must_ be called if and only if BeginListBox returns true, i.e.
            -- when the listbox is currently open
            ImGui.EndListBox()
        end
    
        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("Columns") then
        ImGui.Columns(3)
        ImGui.TextUnformatted("first column")
        ImGui.NextColumn()
        ImGui.TextUnformatted("second column")
        ImGui.NextColumn()
        ImGui.TextUnformatted("third column")
        ImGui.NextColumn()
        ImGui.TextUnformatted("first column second line")
        ImGui.NextColumn()
        ImGui.TextUnformatted("second column second line")
        ImGui.NextColumn()
        ImGui.TextUnformatted("third column second line")
        ImGui.NextColumn()
        ImGui.TextUnformatted("first column third line")
        ImGui.Columns()
        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("Tables") then
        -- Here we will showcase three different ways to output a table.
        -- They are very simple variations of a same thing!
        -- [Method 1] Using TableNextRow() to create a new row, and TableSetColumnIndex() to select the column.
        -- In many situations, this is the most flexible and easy to use pattern.
        -- ImGui.TextUnformatted("Table 1")
        -- ImGui.BeginTable("table1", 3)
        -- for row = 0, 4, 1
        -- do
        --      ImGui.TableNextRow()
        --      for column = 0, 3, 1
        --      do
        --          ImGui.TableSetColumnIndex(column)
        --          ImGui.TextUnformatted("Row " .. row .. " Column " .. column)
        --      end 
        -- end
        -- ImGui.EndTable()
        
        -- ImGui.TextUnformatted("")
        
        -- [Method 2] Using TableNextColumn() called multiple times, instead of using a for loop + TableSetColumnIndex().
        -- This is generally more convenient when you have code manually submitting the contents of each columns.
        ImGui.TextUnformatted("Table 2")
        ImGui.BeginTable("table2", 3)
        for row = 0, 4, 1
        do
          ImGui.TableNextRow()
          ImGui.TableNextColumn()
          ImGui.TextUnformatted("Row " .. row)
          ImGui.TableNextColumn()
          ImGui.TextUnformatted("Some contents")
          ImGui.TableNextColumn()
          ImGui.TextUnformatted("123.456");  
        end
        ImGui.EndTable()
        
        -- ImGui.TextUnformatted("")
        
        -- [Method 3] We call TableNextColumn() _before_ each cell. We never call TableNextRow(),
        -- as TableNextColumn() will automatically wrap around and create new roes as needed.
        -- This is generally more convenient when your cells all contains the same type of data.
        -- ImGui.TextUnformatted("Table 3")
        -- ImGui.BeginTable("table2", 3)
        -- for item = 0, 14, 1
        -- do
        --     ImGui.TableNextColumn()
        --     ImGui.TextUnformatted("Item " .. item)
        -- end
        -- ImGui.EndTable()
      
        ImGui.TreePop()
    end
    
    
    if ImGui.TreeNode("Fonts") then
        ImGui.PushStyleColor(ImGui.Col.Text, 0xFFA89300) -- Strong Artic Blue Text
        ImGui.TextUnformatted("We cannot curently change the font we can change the color")
        ImGui.SetWindowFontScale(1.5)
        ImGui.TextUnformatted("We can also change the scale")
        ImGui.SetWindowFontScale(1.0)
        ImGui.TextUnformatted("Because this is the font scale for the window we need to make sure")
        ImGui.TextUnformatted("we have changed it back to the default of 1.0.")
        ImGui.PopStyleColor()
        ImGui.TreePop()
    end
    
    if ImGui.TreeNode("Misc") then
        -- Create a bullet style enumeration
        ImGui.Bullet(); ImGui.TextUnformatted("Bullet")
        ImGui.Bullet(); ImGui.TextUnformatted("Style")
        ImGui.Bullet(); ImGui.TextUnformatted("Enumeration")
        
        -- Draw a separation line
        ImGui.Separator()
        
        -- Show a progress bar, 1 = 100%
        ImGui.ProgressBar(0.5)

        _, makeRed = ImGui.Checkbox("Complicated Item", makeRed)
        if ImGui.IsItemActive() then
            -- We can create a tooltip that is shown while the item is being clicked (click & hold):
            ImGui.BeginTooltip()
            -- This function configures the wrapping inside the toolbox and thereby its width
            ImGui.PushTextWrapPos(ImGui.GetFontSize() * 10)
            ImGui.TextUnformatted("Here's a long explanation text that describes the purpose of this widget")
            -- Reset the wrapping, this must always be done if you used PushTextWrapPos
            ImGui.PopTextWrapPos()
            ImGui.EndTooltip()
        end
        
        -- Note that caption strings must be unique inside a window! If you need to have
        -- multiple widgets with the same caption, append ## followed by a unique id for an
        -- invisible caption extension:

        ImGui.Button("Button##1")
        ImGui.Button("Button##2")
        
        -- Another variant: Create a custom ID namespace using PushID and PopID in case you want to create
        -- widgets from inside a loop
        for i = 1, 5 do
            ImGui.PushID(i)
            ImGui.Button("Button")
            ImGui.PopID()
        end

        ImGui.TreePop()
    end
    ImGui.End()
end

AddHook("OnRender", "LABEL_01", imDemo);
