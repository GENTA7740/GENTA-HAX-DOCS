function HelpDialog()
pkt = {}
pkt.v0 = "OnDialogRequest"
pkt.v1 = string.format([[add_label_with_icon|big|Script created by GENTA 7740|left|5016|
add_spacer|small
add_textbox|Custom Command script!|left|2480|
add_textbox|/helpscript|left|2480|
add_textbox|/name ( string )|left|2480|
add_textbox|/hair ( int )|left|2480|
add_textbox|/shirt ( int )|left|2480|
add_textbox|/pants ( int )|left|2480|
add_textbox|/feet ( int )|left|2480|
add_textbox|/face ( int )|left|2480|
add_textbox|/hand ( int )|left|2480|
add_textbox|/back ( int )|left|2480|
add_textbox|/mask ( int )|left|2480|
add_textbox|/neck ( int )|left|2480|
add_quick_exit|
end_dialog|||CLOSE|
]])
SendVarlist(pkt)
end


function Hook2(packet)
if packet:find("action|input") and packet:find("/helpscript") then
HelpDialog()
else if packet:find("action|input") and packet:find("/name") then
console("New Name: "..packet:gsub("action|input\n|text|/name ",""))
pkt = {}
pkt.name = packet:gsub("action|input\n|text|/name ","")
SetLocalPlayer(false,pkt)
else if packet:find("action|input") and packet:find("/hair") then
console("hair item: "..GetItemByID(packet:match("/hair (%d+)")).Name)
pkt = {}
pkt.hair = tonumber(packet:match("/hair (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/shirt") then
console("shirt item: "..GetItemByID(packet:match("/shirt (%d+)")).Name)
pkt = {}
pkt.shirt = tonumber(packet:match("/shirt (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/pants") then
console("pants item: "..GetItemByID(packet:match("/pants (%d+)")).Name)
pkt = {}
pkt.pants = tonumber(packet:match("/pants (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/feet") then
console("feet item: "..GetItemByID(packet:match("/feet (%d+)")).Name)
pkt = {}
pkt.feet = tonumber(packet:match("/feet (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/face") then
console("face item: "..GetItemByID(packet:match("/face (%d+)")).Name)
pkt = {}
pkt.face = tonumber(packet:match("/face (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/hand") then
console("hand item: "..GetItemByID(packet:match("/hand (%d+)")).Name)
pkt = {}
pkt.hand = tonumber(packet:match("/hand (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/back") then
console("back item: "..GetItemByID(packet:match("/back (%d+)")).Name)
pkt = {}
pkt.back = tonumber(packet:match("/back (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/mask") then
console("mask item: "..GetItemByID(packet:match("/mask (%d+)")).Name)
pkt = {}
pkt.mask = tonumber(packet:match("/mask (%d+)"))
SetLocalPlayer(true,pkt)
else if packet:find("action|input") and packet:find("/neck") then
console("neck item: "..GetItemByID(packet:match("/neck (%d+)")).Name)
pkt = {}
pkt.necklace = tonumber(packet:match("/neck (%d+)"))
SetLocalPlayer(true,pkt)
end
end
end
end
end
end
end
end
end
end
end
end




HelpDialog()
addHook(Hook2, "OnPacket")
