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

# API list

###### • void console(std::string)
###### • void sleep(int) // Milliseconds
###### • void SendPacketRaw(bool, TankPacketStruct)
###### • void SendPacket(ENetPacketFlag, std::string) // Type, Packet
###### • void findpath(int, int) // x, y
###### • Tile* GetTile(int , int) // x, y
###### • Tile* CheckTile(int, int) // x, y
###### • ItemInfo* GetItemByID(int) // itemID
###### • NetAvatar* GetLocal()

###### • NetAvatar* GetPlayerByNetID(int) // NetID
###### • WorldObject* GetWorldObject()
###### • void CreateDialog(std::string)
###### • Inventory* GetInventory()
###### • World* GetWorld()

###### • void SendVarlist(bool, TankPacketStruct) // effect, packet
###### • void SetLocalPlayer(NetAvatar*)
###### • bool ToggleCheat(std::string, bool)
###### • void addHook(function, std::string)
###### • void Log(std::string)

# Structure

## TankPacketStruct
```
int type // Packet type
int state // Character state
int value // Value
int posX // Player Position X
int posY // Player Position Y
int xspeed // player X speed
int yspeed // player Y speed
int px // Punch X
int py // Punch Y
```

## NetAvatar
```
int posX // X position of Local player
int posY // Y position of Local player
std::string name // name of Local player
std::string country // country code of Local player
int userid // userID of Local player
int status // status of Local player
bool isLeft // is local player facing left
int hair // hair of Local player
int shirt // shirt of Local player
int pants // pants of Local player
int feet // feet of Local player
int face // face of Local player
int hand // hand of Local player
int back // back of Local player
int mask // mask of Local player
int necklace // necklace of Local player
```

## Tile
```
int x // Tile Pos X
int y // Tile Pos Y
int fg // Tile Foreground itemID
int bg // Tile Background itemID
bool readyharvest // Tile Ready harvest
```

## ItemInfo
```
std::string Name // Name of item
int ItemType // Item Type
std::string FileName // Name file texture of item
int Rarity // Item Rarity
int Growth // item growth
int VisualStyle // item visual Style
```

## WorldObject
```
int id // item id
int amount // item amount
int x // item position X
int y // item position Y
```

## World
```
std::string name // current world name
```

# Packet Type

## Raw type
```
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

## ENetPacketFlag
```
ENET_PACKET_FLAG_RELIABLE = 0
ENET_PACKET_FLAG_UNSEQUENCED = 1
ENET_PACKET_FLAG_NO_ALLOCATE = 2
ENET_PACKET_FLAG_UNRELIABLE_FRAGMENT = 3
ENET_PACKET_FLAG_SENT = 8
```

# Hooking
```
OnPacket // Game Text Packet
OnPacketRaw // Game Packet Raw
OnVarlist // Variant list Hook
OnTouchAtWorldCoords // Hook Handle Touch At World Pos
OnChooseItem // Hook choosing item
OnTrackPacket // Hook Track packet
OnGameUpdatePacket // Hook Game Update Packet
```

# Example

## Coming soon!
