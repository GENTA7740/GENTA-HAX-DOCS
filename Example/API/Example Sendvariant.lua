pkt = {}
pkt.v0 = "OnDialogRequest"
pkt.v1 = string.format([[add_label_with_icon|big|Hello world!|left|5016|
add_spacer|small
add_textbox|Hello world!|left|2480|
add_quick_exit|
end_dialog|||CLOSE|
]])
SendVarlist(pkt)
