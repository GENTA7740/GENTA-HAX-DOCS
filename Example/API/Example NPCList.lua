for _, npc in pairs(NPCList())do
console("Type: "..tostring(npc.type).." X: "..tostring(npc.currentX).." Y: "..tostring(npc.currentY).." Target X: "..tostring(npc.targetX).." Target Y: "..tostring(npc.targetY).."")
end