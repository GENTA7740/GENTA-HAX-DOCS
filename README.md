## GentaHax Script Documentation
this documentation will teach you how to make script for GentaHax

## Requirements
- You must know basic lua scripts.
- You must have Genta Hax :v


## File Path
```
Android/data/com.rtsoft.growtopia/script/here.lua
```

##Basic Knowledge
```
bool / boolean, boolean value among true or false
int / integer, integer value is number
string / string, string is string LOL
```

## Function
```
void GetInventory()

# How to use
for _, inv in pairs(GetInventory())do
console("ID:"..inv.id.." Amount:"..inv.amount)
end
# explanation

Print all Inventory Item
```

```
void console(std::string)
calling function OnConsoleMessage, displaying what ever you write into Growtopia Console. nb: only you can see.

# How to use
console("hello world")

Output in GT Console: hello world
```

```
void findpath(int, int)
calling function Path Finders, auto finding path target without teleport back to first position.

# How to use
findpath(10, 10)

# Explanation
it will automatic finding path to coordinate X: 10 Y: 10
```

```
void findpathdelay(int) // in miliseconds
calling function delay path finders.

# How to use
findpathdelay(100)

# Explanation
it will set path finders delay to 100 miliseconds
```

```
void sleep(int) // in miliseconds
calling function sleep, it will pause execution until sleep done.

# How to use
sleep(1000)

# Explanation
it will pause execution for 1 second
1000 = 1 second
2000 = 2 second
```

```
int checkamount(int)
calling function check item amount on your inventory.

# How to use
if(checkamount(16) < 2) 
//execute your code
end

# Explanation
16 is Grass itemID so it will check if grass amount less than 2 it will execute your code.
```

```
void SendPacket(int, std::string)

# How to use
SendPacket(2, "action|input\n|text|Hello")

# Explanation
it will send chat hello
2 is packet flags
```

```
void SendPacketRaw(bool, TankPacketStruct)

# How to use
pkt {}
pkt.type = 3
pkt.px = 10
pkt.py = 5
pkt.value = 18
pkt.posX = GetLocal().posX
pkt.posY = GetLocal().posY
SendPacketRaw(false, pkt)

# Explanation
it will send punching block on coordinate X: 10 Y: 5

pkt.type is Packet Type and 3 is PACKET_TILE_CHANGE_REQUEST
pkt.px is PunchX / Punch Coordinate X
pkt.py is PunchY / Punch Coordinate Y
pkt.posX is Player Position X
pkt.posY is Player Position Y
pkt.value = 18 is value itemID, 18 is Fist so it will send punch packet, if you change it to 32 ( wrench ) it will wrenching any block on coordinate X: 10 Y: 5
```

```
void CreateDialog()

# How to use

CreateDialog("add_textbox|Test Dialog?|left\nadd_quick_exit|\nend_dialog|end|Cancel||")

# Explanation

just try it

```

```
string GetCurrentWorldName()

# How to use

console(GetCurrentWorldName())

# Explanation

Print Current World Name

```


```
void GetWorldObject()

# How to use
for _, drop in pairs(GetWorldObject())do
console("X:"..drop.x.." Y:"..drop.y.." ItemID:"..drop.id.." Amount:"..drop.amount)
end
# explanation

Print all Dropped Object

```

```
void GetTile()

# How to use

for _, tile in pairs(GetTile()) do
if(tile.fg == 2) then
findpath(tile.x, tile.y)
break
end
end

# Explanation

if the code executed, it will scan all tile and find tile foreground ID 2 ( itemID: dirt ) after tile found it will find path to tile

```

```
void CheckTile()

# How to use

for _, tile in pairs(GetTile()) do
if(tile.fg == 2 and CheckTile(tile.x,tile.y-1).fg == 0) then
findpath(tile.x, tile.y)
break
end
end

# Explanation

if the code executed, it will scan all tile and find tile foreground ID 2 ( itemID: dirt ) then it will check foreground id above dirt and if foreground id is 0 it will finding path.

```

## Structure
```
Packet Structure:

    PACKET_STATE = 0,
    PACKET_CALL_FUNCTION = 1
    PACKET_UPDATE_STATUS = 2
    PACKET_TILE_CHANGE_REQUEST = 3
    PACKET_SEND_MAP_DATA = 4
    PACKET_SEND_TILE_UPDATE_DATA = 5
    PACKET_SEND_TILE_UPDATE_DATA_MULTIPLE = 6
    PACKET_TILE_ACTIVATE_REQUEST = 7
    PACKET_TILE_APPLY_DAMAGE = 8
    PACKET_SEND_INVENTORY_STATE = 9
    PACKET_ITEM_ACTIVATE_REQUEST = 10
    PACKET_ITEM_ACTIVATE_OBJECT_REQUEST = 11
    PACKET_SEND_TILE_TREE_STATE = 12
    PACKET_MODIFY_ITEM_INVENTORY = 13
    PACKET_ITEM_CHANGE_OBJECT = 14
    PACKET_SEND_LOCK = 15
    PACKET_SEND_ITEM_DATABASE_DATA = 16
    PACKET_SEND_PARTICLE_EFFECT = 17
    PACKET_SET_ICON_STATE = 18
    PACKET_ITEM_EFFECT = 19
    PACKET_SET_CHARACTER_STATE = 20
    PACKET_PING_REPLY = 21
    PACKET_PING_REQUEST = 22
    PACKET_GOT_PUNCHED = 23
    PACKET_APP_CHECK_RESPONSE = 24
    PACKET_APP_INTEGRITY_FAIL = 25
    PACKET_DISCONNECT = 26
    PACKET_BATTLE_JOIN = 27
    PACKET_BATTLE_EVEN = 28
    PACKET_USE_DOOR = 29
    PACKET_SEND_PARENTAL = 30
    PACKET_GONE_FISHIN = 31
    PACKET_STEAM = 32
    PACKET_PET_BATTLE = 33
    PACKET_NPC = 34
    PACKET_SPECIAL = 35
    PACKET_SEND_PARTICLE_EFFECT_V2 = 36
    GAME_ACTIVE_ARROW_TO_ITEM = 37
    GAME_SELECT_TILE_INDEX = 38

```

```
Raw Packet Structure:
pkt {}
pkt.type = 0 // Packet Type (int)
pkt.state = 0 // Character State (int)
pkt.xspeed = 0 //XSpeed (int)
pkt.yspeed = 0 // YSpeed (int)
pkt.px = 0 //PunchX (int)
pkt.py = 0 // PunchY (int)
pkt.value = 0 // a Value (int)
pkt.posX = 0 // Player Position X (int)
pkt.posY = 0 // Player Position Y (int)

```

```
Checktile Structure
tile.x = Get X position of tile (int)
tile.y = Get Y position of tile (int)
tile.fg = Get Foreground tile itemID (int)
tile.bg = Get Background tile itemID (int)
tile.readyharvest = Get Fruit Bloom Progress Percent (bool) ( true = Ready Harvest )
```

```
GetWorldObject() Structure
obj.x = Get X position of object ( int )
obj.y = Get Y position of object (int)
obj.amount = Get Amount of Object (int)
obj.id = Get itemID of Object (int)
```

```
GetTile Structure
tile.x = Get X position of tile (int)
tile.y = Get Y position of tile (int)
tile.fg = Get Foreground tile itemID (int)
tile.bg = Get Background tile itemID (int)
tile.readyharvest = Get Fruit Bloom Progress Percent (bool) ( true = Ready Harvest )
```

```
GetLocal Structure
GetLocal().posX = Get X position of Local player (int)
GetLocal().posY = Get Y position of Local player (int)
GetLocal().name = Get name of Local player (string)
GetLocal().country = Get country code of Local player (string)
GetLocal().userid = Get userID of Local player (int)
GetLocal().status = Get status of Local player (int)
GetLocal().isLeft = Get is Facing Left of Local player (bool)
GetLocal().hair = Get hair of Local player (int)
GetLocal().shirt = Get shirt of Local player (int)
GetLocal().pants = Get pants of Local player (int)
GetLocal().feet = Get feet of Local player (int)
GetLocal().face = Get face of Local player (int)
GetLocal().hand = Get hand of Local player (int)
GetLocal().back = Get back of Local player (int)
GetLocal().mask = Get mask of Local player (int)
GetLocal().necklace = Get necklace of Local player (int)
```

``` 
GetInventory() Structure
GetInventory().id = Get itemID from Inventory Local Player ( int )
GetInventory().amount = Get Amount of item from Inventory Local Player ( int )
```
