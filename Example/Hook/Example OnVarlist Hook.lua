fastdrop = false
wrenchpull = false
dropcount = 0
skipdrop = false
function HelpDialog()
pkt = {}
pkt.v0 = "OnDialogRequest"
pkt.v1 = string.format([[add_label_with_icon|big|Script created by GENTA 7740|left|5016|
add_spacer|small
add_textbox|Script command!|left|2480|
add_textbox|/helpscript ## show command list|left|2480|
add_textbox|/wp ## wrench pull|left|2480|
add_textbox|/uacc ## Fast un-access |left|2480|
add_textbox|/fd ## fast drop|left|2480|
add_textbox|/dcount (int) ## Drop count, 0 = all|left|2480|
add_quick_exit|
end_dialog|||CLOSE|
]])
SendVarlist(pkt)
end

function DropConfirm()
pkt = {}
pkt.v0 = "OnDialogRequest"
pkt.v1 = string.format([[add_label_with_icon|big|You will drop all item!|left|5016|
add_spacer|small
add_quick_exit|
end_dialog|confirm_drop|Cancel|OK|
]])
SendVarlist(pkt)
end

function Hooked(vlist)
if vlist[0]:find("OnDialogRequest") and vlist[1]:find("end_dialog|drop_item") and fastdrop then
if(dropcount == 0) then
pkt = string.format([[action|dialog_return
dialog_name|drop_item
itemID|%d|
count|%d
]], vlist[1]:match("itemID|(%d+)"), vlist[1]:match("count||(%d+)") )
if(skipdrop == false) then
DropConfirm()
else
SendPacket(2,pkt)
end
else
pkt = string.format([[action|dialog_return
dialog_name|drop_item
itemID|%d|
count|%d
]], vlist[1]:match("itemID|(%d+)"), dropcount )
SendPacket(2,pkt)
end
return true
else if vlist[0]:find("OnDialogRequest") and vlist[1]:find("add_button|report_player|") and wrenchpull then
pkt = string.format([[action|dialog_return
dialog_name|popup
netID|%d|
netID|%d|
buttonClicked|pull
]], vlist[1]:match("netID|(%d+)"), vlist[1]:match("netID|(%d+)") )
SendPacket(2,pkt)
return true
else if vlist[0]:find("OnDialogRequest") and vlist[1]:find("Remove Your Access From World") then
SendPacket(2, "action|dialog_return\ndialog_name|unaccess\n")
console("`2Success un-acc")
return true
end
end
end
end

function HookJembut(packet)
if packet:find("action|input") and packet:find("/fd") then
if(fastdrop) then fastdrop = false console("Fast drop `4Deactive")
else fastdrop = true console("Fast drop `2Active")
end --
return true
else if packet:find("action|input") and packet:find("/wp") then
if(wrenchpull) then wrenchpull = false console("Wrench pull `4Deactive")
else wrenchpull = true console("Wrench pull `2Active")
end --
return true
else if packet:find("action|input") and packet:find("/uacc") then
console("Un Accessing")
SendPacket(2,"action|input\n|text|/unaccess")
return true
else if packet:find("action|input") and packet:find("/helpscript") then
HelpDialog()
return true
else if packet:find("action|input") and packet:find("/dcount") then
dropcount = tonumber(packet:match("/dcount (%d+)"))
console("Fast drop count: "..dropcount)
return true
else if packet:find("confirm_drop") then
skipdrop = true
console("You confirmed drop all")
return true
end
end
end
end
end
end
end
HelpDialog()
addHook(Hooked, "OnVarlist")
addHook(HookJembut,"OnPacket")
