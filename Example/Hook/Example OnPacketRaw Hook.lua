function HookRaw(raw)
console("Type: "..raw.type)
console("X: "..raw.x)
console("Y: "..raw.y)
console("value: "..raw.value)
console("px: "..raw.px)
console("py: "..raw.py)
console("xspeed: "..raw.xspeed)
console("yspeed: "..raw.yspeed)
console("charstate: "..raw.state)
return false
end

addHook(HookRaw,"OnPacketRaw")
