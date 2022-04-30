function GtwMales(pos)
Log("foreground: "..CheckTile(pos.x/32, pos.y / 32).fg)
Log("background: "..CheckTile(pos.x /32, pos.y/32).bg)
end

addHook(GtwMales,"OnTouchAtWorldCoords")