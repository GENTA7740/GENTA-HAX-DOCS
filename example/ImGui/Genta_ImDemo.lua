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
    -- This function is called for every frame. Use this function to create your GUI.n
    -- so you know which of these windows is currently being built.

    -- If you additionally need the current width and height of the window, use these functions:
    local win_width = imgui.GetWindowWidth()
    local win_height = imgui.GetWindowHeight()
    -- These function return the window's width and height in boxels.

    -- The easiest thing we can do in imgui is drawing text. The function is called TextUnformatted because
    -- it doesn't support C-style format strings. imgui has a function called Text() that does support these
    -- format strings, but it is not supported in lua.
    imgui.TextUnformatted("Hello, World! Imgui 1.85 demo for FlyWithLua")

    -- Since TextUnformatted does not support format strings, you can use lua to create a string on the fly:
    imgui.TextUnformatted("Window size: " .. win_width .. ", " .. win_height)

    -- imgui automatically arranges all widgets from top to bottom, so the following text is drawn below:
    imgui.TextUnformatted("Two Widgets")
    -- It is possible to put a widget on the same line, i.e. avoiding the automatic line feed:
    imgui.SameLine()
    imgui.TextUnformatted("One Line.")

    -- To maintain a tidy layout, let's show the next windows grouped in tree nodes.
    -- The user can collapse or expand these nodes to show or hide the content.
    -- It is not required to put widgets into tree nodes, this is just an example.
    if imgui.TreeNode("Styling Widgets") then
        -- The TreeNode function creates such a tree node. The parameter is the label of the node.
        -- The function returns true if the node is currently opened, so the if statement takes care
        -- that the contained widgets are only drawn if the node is currently expanded.

        -- It is possible to place widgets at arbitrary coordinates by manipulating the draw cursor's position.
        -- Let's center a text horizontally by first measuring its size and then putting it at the center of the line:
        local text = "Centered Text"
        local text_width, text_height = imgui.CalcTextSize(text)
        imgui.SetCursorPos(win_width / 2 - text_width / 2, imgui.GetCursorPosY())
        imgui.TextUnformatted(text)
        -- CalcTextSize returns the width and height of a text in boxels without drawing it.
        -- GetCursorPosX and GetCursorPosY return the position where the next widget will be placed.
        -- SetCursorPos can be used to manipulate this position.
        -- imgui's coordinates have the origin in the upper left and the axes grow to the right and to the bottom.

        -- The following function changes the color of all widgets until PopStyleColor is called.
        -- The format is AABBGGRR where A is alpha and B, G and R are blue, green and red.
        -- So if you have an HTML color like #2B65EC (ocean blue), swap the first two and last two hex digits
        -- and prefix it with FF to use it:
        imgui.PushStyleColor(imgui.constant.Col.Text, 0xFFEC652B)
        imgui.TextUnformatted("Ocean Blue Text")
        imgui.TextUnformatted("Also Ocean Blue")
        -- In this example we changed the value of imgui.constant.Col.Text which is the foreground text
        -- color. For other supported style colors that can be changed, see footnote [1] below.
        
        -- Restore the previous style, this _must_ be called after each pushed style:
        imgui.PopStyleColor()

        imgui.TextUnformatted("No longer Ocean Blue")

        -- This function must be called at the end of every tree node to tell imgui that the code after
        -- it is not part of the TreeNode anymore.
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Buttons") then
        -- The following function creates a button:
        if imgui.Button("Push Me") then
            -- The Button function creates a button with the given label. It returns true in the
            -- moment where the button is released, i.e. the if statement is used to check whether
            -- the action behind the button should now be executed. Let's make the button toggle a variable:
            makeRed = not makeRed
        end
        
        -- Use the variable to change the color of the text
        if makeRed then
            imgui.PushStyleColor(imgui.constant.Col.Text, 0xFF0000FF)
        else
            imgui.PushStyleColor(imgui.constant.Col.Text, 0xFF00FF00)
        end

        imgui.TextUnformatted("Some Text")
        imgui.PopStyleColor()
        
        -- If you want to trigger the action while the button is clicked and not only when it is released:
        imgui.Button("Click and hold")
        if imgui.IsItemActive() then
            makeRed = not makeRed
        end
        
        -- Control the size of a button 
        if imgui.Button("Button 1", 65, 25) then
        
        end
        -- Keep the next button on the same line.
        imgui.SameLine()
        -- Control position of next button
        imgui.SetCursorPosX(150)
        
        if imgui.Button("Button 2", 65, 25) then
        
        end
        imgui.SameLine()
        imgui.SetCursorPosX(150 * 2)
        
        if imgui.Button("Button 3", 65, 25) then
        
        end
        
        -- Radio buttons: Specify whether the choice is currently active as parameter.
        -- Returns true when the choice is selected.
        if imgui.RadioButton("Choice 1", choice == 1) then
            choice = 1
        end
        if imgui.RadioButton("Choice 2", choice == 2) then
            choice = 2
        end
        if imgui.RadioButton("Choice 3", choice == 3) then
            choice = 3
        end
        
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Checkboxes") then
        -- The following function creates a checkbox:
        local changed, newVal = imgui.Checkbox("Make text red", makeRed)
        -- The first parameter is the caption of the checkbox, it will be displayed right of the checkbox.
        -- The second parameter is the current boolean value.
        
        -- The function returns two values: a bool to indicate whether the value was changed and the new value. 
        if changed then
            makeRed = newVal
        end

        if makeRed then
            imgui.PushStyleColor(imgui.constant.Col.Text, 0xFF0000FF)
        else
            imgui.PushStyleColor(imgui.constant.Col.Text, 0xFF00FF00)
        end

        imgui.TextUnformatted("Some Text")
        imgui.PopStyleColor()
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Sliders") then
        -- The following function creates a slider:
        local changed, newVal = imgui.SliderFloat("Slider Caption", sliderVal, 0, 100000, "Value: %.2f")
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
        local changed, newVal = imgui.SliderFloat("Power Slider", sliderVal, 0, 100000, "Value: %.2f", 3.0)
        if changed then
            sliderVal = newVal
        end
        
        -- For non-decimals:
        local changed, newVal = imgui.SliderInt("Int Slider", sliderVal, 0, 100000, "Value: %.0f")
        if changed then
            sliderVal = newVal
        end
        
        -- For angles: 
        local changed, newVal = imgui.SliderAngle("Angle Slider", angle, -180, 180, "Value: %.0f")
        if changed then
            angle = newVal
        end

        imgui.TreePop()
    end
    
    if imgui.TreeNode("ComboBox") then
    
        local choices = {"Choice 1", "Choice 2", "Choice 3"}

        -- BeginCombo starts a combo box. The first parameter is the label, the
        -- second parameter the text of the currently selected choice.
        if imgui.BeginCombo("Combo Box", choices[choice]) then
            -- Loop over all choices
            for i = 1, #choices do
                -- The Selectable function adds a choice to a combobox.
                -- The first parameter is the label, the second one
                -- should be true if this choice is currently selected.
                if imgui.Selectable(choices[i], choice == i) then
                    -- Selectable returns true when a new choice was selected,
                    -- we should then copy the choice into our choice variable
                    choice = i
                end
            end
            -- _Must_ be called if and only if BeginCombo returns true, i.e.
            -- when the combobox is currently open
            imgui.EndCombo()
        end
        
        -- Here is an easier example to understand the loop above
        if imgui.BeginCombo("Combo Box 2", "", imgui.constant.ComboFlags.NoPreview) then
            if imgui.Selectable("Choice A", choice == 1) then
                choice = 1
            end
            if imgui.Selectable("Choice B", choice == 2) then
                choice = 2
            end
            if imgui.Selectable("Choice C", choice == 3) then
                choice = 3
            end
            imgui.EndCombo()
        end
        
    
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Drag Controls") then
        -- These are somewhat similar to sliders but you can drag them multiple 
        -- times at the same position to continously increase or decrease the value
        local changed, newVal = imgui.DragFloat("Drag Float", sliderVal, 1.0, 0, 1000, "%.2f", 1.0)
        -- Parameters: Label, value, speed, min, max, caption, power
        
        if changed then
            sliderVal = newVal
        end

        local changed, newVal = imgui.DragInt("Drag Int", sliderVal, 1.0, 0, 1000, "%.2f", 1.0)
        if changed then
            sliderVal = newVal
        end
        
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Plots") then
        -- demo data
        local values = {1, 3, 2, 5, 0, 6, -3}
        
        -- the following function creates a graphical plot of the values:
        imgui.PlotLines("Value Plot", values, #values)
        -- The first parameter is the caption
        -- The second parameters is the value array
        -- The third parameter is the number of values to plot (here: all values).
        -- The next parameters are optional:
        --  4: offset into the array to indicate where to start
        --  5: overlay text to show on the plot
        --  6: minimum y value for scaling. Pass FLT_MAX for auto-scale
        --  7: maximum y value for scaling. Pass FLT_MAX for auto-scale
        --  8: graph size width
        --  9: graph size height
        
        imgui.PlotLines("", values, #values - 1, 1, "Plot", -10, FLT_MAX, win_width, 100)
        -- Now the plot goes from -10 to the max value in the array and uses the full window width.
        -- The first value is ignored since we use 1 as offset and only go to num - 1
        
        -- Instead of using a line plot, it's also possible to use histogram bins. The parameters are the same.
        imgui.PlotHistogram("Value Histogram", values, #values)
        
        -- Note that you will have to calculate the actual histogram yourself, this histogram function simply
        -- uses bars instead of lines but doesn't do the histogram calculation.

        -- See the FPS example for an actual histogram and plotting of live data.

        imgui.TreePop()
    end
    
    if imgui.TreeNode("Input") then
        -- Allow the user to input text
        local changed, newText = imgui.InputText("One Line Text", text, 255)
        -- Parameters: Label, current text, maximum number of allowed characters

        if changed then
            text = newText
        end

        local changed, newText2 = imgui.InputTextMultiline("Multiline Text", text2, 500)
        -- Parameters: Label, current text, maximum number of allowed characters

        if changed then
            text2 = newText2
        end

        local changed, newText3 = imgui.InputTextWithHint("Text With a Hint", "hint", text3, 255)
        -- Parameters: Label, current text, maximum number of allowed characters

        if changed then
            text3 = newText3
        end
        
        -- Allow the user to input an integer, either using the keyboard or by clicking + / -
        local changed, newInt = imgui.InputInt("Input int", sliderVal)
        if changed then
            sliderVal = newInt
        end
        
        -- The +/- steps can optionally be changed:
        local changed, newInt = imgui.InputInt("Input int2", sliderVal, 10)
        if changed then
            sliderVal = newInt
        end

        imgui.TreePop()
    end
    
    if imgui.TreeNode("Drawing") then
        local cx, cy = imgui.GetCursorScreenPos()
        
        -- Create a kind of canvas of size 100x100.
        -- The previous variable remembers the top left
        -- edge of the canvas so we can use it as relative
        -- coordinates to draw inside the widget using
        -- absolute coordinates.
        imgui.Dummy(100, 100)
        
        -- Parameters: x1, y1, x2, y2, color, thickness
        imgui.BG.AddLine(cx, cy, cx + 20, cy + 20, 0xFF0000FF, 2)
        imgui.BG.AddLine(cx, cy + 20, cx + 20, cy, 0xFF0000FF, 2)
        
        -- Prameters: x1, y1, x2, y2, color, roundness
        imgui.BG.AddRect(cx, cy, cx + 20, cy + 20, 0xFFFF0000, 0.5)

        -- Prameters: x1, y1, x2, y2, color, roundness
        imgui.BG.AddRectFilled(cx + 20, cy, cx + 40, cy + 20, 0xFFFF0000, 0.5)
    
        -- Parameters: x1, y1, x2, y2, x3, y3, color, thickness 
        imgui.BG.AddTriangle(cx, cy + 50, cx + 40, cy + 50, cx + 20, cy + 20, 0xFF00FF00, 2.0)

        -- Parameters: x1, y1, x2, y2, x3, y3, color
        imgui.BG.AddTriangleFilled(cx + 40, cy + 50, cx + 80, cy + 50, cx + 40, cy + 20, 0xFF00FF00)

        -- Parameters: x1, y1, r, color, segments, thickness
        imgui.BG.AddCircle(cx + 80, cy + 20, 20, 0xFF00FF00, 20, 1.0)

        -- Parameters: x1, y1, r, color
        imgui.BG.AddCircleFilled(cx + 80, cy + 20, 10, 0xFF00FF00)
        
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Images") then
        -- Draw a previously loaded image
        imgui.Image(image_id, win_width, 450 / 800 * win_width)
        -- Prameters: image id returned by float_wnd_load_image, diplay width, display height
        
        imgui.TreePop()
    end
    
    if imgui.TreeNode("ListBox") then
        local choices = {"Choice 1", "Choice 2", "Choice 3"}
        
        -- BeginListBox starts a list box. The first parameter is the label, the
        -- second parameter the text of the currently selected choice.
        if imgui.BeginListBox("List Box", choices[choice]) then
            -- Loop over all choices
            for i = 1, #choices do
                -- The Selectable function adds a choice to a listbox.
                -- The first parameter is the label, the second one
                -- should be true if this choice is currently selected.
                if imgui.Selectable(choices[i], choice == i) then
                    -- Selectable returns true when a new choice was selected,
                    -- we should then copy the choice into our choice variable
                    choice = i
                end
            end
            -- _Must_ be called if and only if BeginListBox returns true, i.e.
            -- when the listbox is currently open
            imgui.EndListBox()
        end
    
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Columns") then
        imgui.Columns(3)
        imgui.TextUnformatted("first column")
        imgui.NextColumn()
        imgui.TextUnformatted("second column")
        imgui.NextColumn()
        imgui.TextUnformatted("third column")
        imgui.NextColumn()
        imgui.TextUnformatted("first column second line")
        imgui.NextColumn()
        imgui.TextUnformatted("second column second line")
        imgui.NextColumn()
        imgui.TextUnformatted("third column second line")
        imgui.NextColumn()
        imgui.TextUnformatted("first column third line")
        imgui.Columns()
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Tables") then
        -- Here we will showcase three different ways to output a table.
        -- They are very simple variations of a same thing!
        -- [Method 1] Using TableNextRow() to create a new row, and TableSetColumnIndex() to select the column.
        -- In many situations, this is the most flexible and easy to use pattern.
        -- imgui.TextUnformatted("Table 1")
        -- imgui.BeginTable("table1", 3)
        -- for row = 0, 4, 1
        -- do
        --      imgui.TableNextRow()
        --      for column = 0, 3, 1
        --      do
        --          imgui.TableSetColumnIndex(column)
        --          imgui.TextUnformatted("Row " .. row .. " Column " .. column)
        --      end 
        -- end
        -- imgui.EndTable()
        
        -- imgui.TextUnformatted("")
        
        -- [Method 2] Using TableNextColumn() called multiple times, instead of using a for loop + TableSetColumnIndex().
        -- This is generally more convenient when you have code manually submitting the contents of each columns.
        imgui.TextUnformatted("Table 2")
        imgui.BeginTable("table2", 3)
        for row = 0, 4, 1
        do
          imgui.TableNextRow()
          imgui.TableNextColumn()
          imgui.TextUnformatted("Row " .. row)
          imgui.TableNextColumn()
          imgui.TextUnformatted("Some contents")
          imgui.TableNextColumn()
          imgui.TextUnformatted("123.456");  
        end
        imgui.EndTable()
        
        -- imgui.TextUnformatted("")
        
        -- [Method 3] We call TableNextColumn() _before_ each cell. We never call TableNextRow(),
        -- as TableNextColumn() will automatically wrap around and create new roes as needed.
        -- This is generally more convenient when your cells all contains the same type of data.
        -- imgui.TextUnformatted("Table 3")
        -- imgui.BeginTable("table2", 3)
        -- for item = 0, 14, 1
        -- do
        --     imgui.TableNextColumn()
        --     imgui.TextUnformatted("Item " .. item)
        -- end
        -- imgui.EndTable()
      
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Child Window") then
--	imgui.PushStyleColor(imgui.constant.Col.ChildBg, 0xFF000000) -- Black Background
--	imgui.PushStyleColor(imgui.constant.Col.ChildBg, 0xFFFFFFFF) -- White Background
--	imgui.PushStyleColor(imgui.constant.Col.ChildBg, 0xFF0000FF) -- Red Background
--	imgui.PushStyleColor(imgui.constant.Col.ChildBg, 0xFF00FF00) -- Green Background
--	imgui.PushStyleColor(imgui.constant.Col.ChildBg, 0xFFFF0000) -- Blue Background
	imgui.PushStyleColor(imgui.constant.Col.ChildBg, 0xFFA89300) -- Strong Artic Blue Background
--      imgui.PushStyleColor(imgui.constant.Col.ChildBg, 0xFFA8A800) -- Strong Cyan Background
        imgui.BeginChild("test", 640, 480)
        imgui.PopStyleColor()
        if imgui.Button("Button One") then  -- Standard size button
        
        end
        imgui.SameLine()
        imgui.SetCursorPosX(150)  -- Control where next button will be placed
        
        if imgui.Button("Button Two", 100, 50) then  -- Bigger than normal sized button
        
        end
        
        imgui.SameLine()
        imgui.SetCursorPosX(150 * 2)
        
        if imgui.Button("Button Three", 100, 50) then
        
        end
        
        imgui.EndChild()
    
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Fonts") then
        imgui.PushStyleColor(imgui.constant.Col.Text, 0xFFA89300) -- Strong Artic Blue Text
        imgui.TextUnformatted("We cannot curently change the font we can change the color")
        imgui.SetWindowFontScale(1.5)
        imgui.TextUnformatted("We can also change the scale")
        imgui.SetWindowFontScale(1.0)
        imgui.TextUnformatted("Because this is the font scale for the window we need to make sure")
        imgui.TextUnformatted("we have changed it back to the default of 1.0.")
        imgui.PopStyleColor()
        imgui.TreePop()
    end
    
    if imgui.TreeNode("Misc") then
        -- Create a bullet style enumeration
        imgui.Bullet(); imgui.TextUnformatted("Bullet")
        imgui.Bullet(); imgui.TextUnformatted("Style")
        imgui.Bullet(); imgui.TextUnformatted("Enumeration")
        
        -- Draw a separation line
        imgui.Separator()
        
        -- Show a progress bar, 1 = 100%
        imgui.ProgressBar(0.5)

        _, makeRed = imgui.Checkbox("Complicated Item", makeRed)
        if imgui.IsItemActive() then
            -- We can create a tooltip that is shown while the item is being clicked (click & hold):
            imgui.BeginTooltip()
            -- This function configures the wrapping inside the toolbox and thereby its width
            imgui.PushTextWrapPos(imgui.GetFontSize() * 10)
            imgui.TextUnformatted("Here's a long explanation text that describes the purpose of this widget")
            -- Reset the wrapping, this must always be done if you used PushTextWrapPos
            imgui.PopTextWrapPos()
            imgui.EndTooltip()
        end
        
        -- Note that caption strings must be unique inside a window! If you need to have
        -- multiple widgets with the same caption, append ## followed by a unique id for an
        -- invisible caption extension:

        imgui.Button("Button##1")
        imgui.Button("Button##2")
        
        -- Another variant: Create a custom ID namespace using PushID and PopID in case you want to create
        -- widgets from inside a loop
        for i = 1, 5 do
            imgui.PushID(i)
            imgui.Button("Button")
            imgui.PopID()
        end

        imgui.TreePop()
    end
end

AddHook("OnRender", "LABEL_01", imDemo);
