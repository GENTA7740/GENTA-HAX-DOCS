-- VARIABLE --
seedid = 17     --Seed ID
blockid = 16     --Block ID
platpabrik = 102      --ID Platform for 100% Auto farm
hitcount = 2     --Hit break block 
harvesting = false
planting = false
pos_x = 0 -- don't touch!
pos_y = 0 -- don't touch!
-- END --

-- API Used
-- void SendPacketRaw(type, raw)
-- PlayerInventory* GetInventory()
-- Tile* GetTile()
-- bool findpath(x,y) ( True == success / False == Fail )
-- Tile* CheckTile(x,y)
-- void sleep(int) (milliseconds)
-- NetAvatar* GetLocal()

-- Note: addHook on multibot still error! so don't use addHook. wait next patch / update :D


function FindItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end
function plants(x , y, seedo)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.type = 3;
pkt.value = seedo;
pkt.posX = GetLocal().posX
pkt.posY = GetLocal().posY
SendPacketRaw(1, pkt);
end

function putb(x , y, bid)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.type = 3;
pkt.value = bid;
pkt.posX = math.floor(GetLocal().posX)
pkt.posY = math.floor(GetLocal().posY)
SendPacketRaw(1, pkt);
end

function punch(x , y)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.type = 3;
pkt.value = 18;
pkt.posX = math.floor(GetLocal().posX)
pkt.posY = math.floor(GetLocal().posY)
SendPacketRaw(1, pkt);
end

function wrench(x , y)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.type = 3;
pkt.value = 32;
pkt.posX = GetLocal().posX
pkt.posY = GetLocal().posY
SendPacketRaw(1, pkt);
end



function pnb()
findpath(pos_x, pos_y)
sleep(100)
end

function pnb1()
    for _, tile in pairs(GetTile()) do
	    if(tile.x == pos_x and tile.y == pos_y) then
		    if(CheckTile(tile.x-1, tile.y).fg == 0 ) then
			    sleep(200)
                putb(tile.x-1, tile.y, blockid)
			else
			    for i = 1, hitcount do
				punch(tile.x-1, tile.y)
                sleep(10)
				end
			end
		end
	end
end




function harvest()
    for _, tile in pairs(GetTile())do
	    if(tile.fg == seedid and tile.readyharvest == true) then
			if(CheckTile(tile.x,tile.y+1).fg == platpabrik) then
				if(math.floor(tile.y) == math.floor(pos_y)) then
					findpath(tile.x, tile.y)
					sleep(100)
					punch(tile.x, tile.y)
					sleep(200)
					return true
				end
			end
		end
	end
	return false
end

function plant()
    for _, tile in pairs(GetTile()) do
	    if(tile.fg == platpabrik) then
			if(CheckTile(tile.x,tile.y-1).fg == 0) then
				if(tile.y - 1 == pos_y) then
					findpath(tile.x, tile.y-1)
					sleep(100)
                    plants(tile.x, tile.y-1, seedid)
                    sleep(200)
					return true
				end
			end
		end
	end
	return false
end



function farmshit()
pos_x = math.floor(GetLocal().posX / 32) -- Save Pos X
pos_y = math.floor(GetLocal().posY / 32) -- Save Pos Y
while true do
        pnb()
        sleep(10)
        if (math.floor(FindItem(blockid)) >= 10) then
            if (math.floor(FindItem(seedid)) < 100) then 
             pnb1()             
            else
                planting = true
                while planting do
                    planting = plant()
                    if (math.floor(FindItem(seedid)) <= 10) then
                        planting = false
                    end
                end
              pnb()
              sleep(300)
              -- Here you can add logic Drop / Put to vend 
               sleep(100)
            end
        else
            harvesting = true
            while harvesting do
                harvesting = harvest()
                if (math.floor(FindItem(blockid)) >= 180) then
                    harvesting = false
                end
            end
            if (math.floor(FindItem(blockid)) < 10 ) then
                planting = true
                while planting do
                    planting = plant()
                    if (math.floor(FindItem(seedid)) <= 10) then
                        planting = false
                    end
                end
                
                sleep(100)
            end
        end
      --collectgarbage('collect') -- Clear unused data
end
end

farmshit()
