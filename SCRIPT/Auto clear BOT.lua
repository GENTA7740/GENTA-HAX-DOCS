function breaking(x , y)
    pkt = {}
    pkt.px = x;
    pkt.py = y;
    pkt.type = 3;
    pkt.value = 18;
	pkt.posX = GetLocal().posX
	pkt.posY = GetLocal().posY
    SendPacketRaw(1, pkt);
    sleep(170)
    findingdirt()
end

function findingdirt()
    for _, tile in pairs(GetTile()) do
		if(tile.bg == 14) then 
		    if(CheckTile(tile.x, tile.y).fg ~= 8 ) then
				if(CheckTile(tile.x + 1, tile.y).fg == 8 ) then
			        breaking(tile.x + 1, tile.y + 1)
					break
				else
					findpath(tile.x, tile.y -1)
			        breaking(tile.x, tile.y)
					break
				end
		    end
		end
	end
end

findingdirt()