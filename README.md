[![Discord](https://img.shields.io/discord/870604052281573406)](https://discord.gg/JTM9b6XR3A)
## GentaHax Script Documentation
this documentation will teach you how to make script for GentaHax
## Requirements
- You must know basic lua scripts.
- You must have Genta Hax :v
- Lua programming basic knowledge [Lua site](https://lua.org)

## File Path
```
Android/data/com.rtsoft.growtopia/script/here.lua
```

# Basic Knowledge
> float
> Float is a shortened term for "floating point." By definition, it's a fundamental data type built into the compiler that's used to define numeric values with floating decimal points.

> uint8_t 
> unsigned integer type with width of exactly 8, 16, 32 and 64 bits respectively.

> uint32_t
> unsigned integer type with width of exactly 8, 16, 32 and 64 bits respectively.

> int32_t
> signed integer type with width of exactly 8, 16, 32 and 64 bits respectively
with no padding bits and using 2's complement for negative values.

> bool
> A boolean data type in lua is defined using the keyword bool. Usually, 1 ( true ) and 0 ( false ) are assigned to boolean variables as their default numerical values.

> int 
> integer

> string
> String is a collection of characters.

# API list

###### • bool LogToConsole(std::string)
###### • bool SleepMS(int) // Milliseconds
###### • bool SleepM(int) // Seconds
###### • bool SendPacketRaw(bool send_to_client, TankPacketStruct packet, int type)
###### • void SendPacket(int type, std::string pkt) // Type, Packet
###### • bool findpath(int x, int y, int delayMS) // x, y note: it will return true if path found, opposite it will return false if path not found
###### • std::vector<Tile> GetTile()
###### • Tile* CheckTile(int x, int y)
###### • ItemInfo* GetItemByID(int itemID)
###### • NetAvatar* GetLocal()
###### • NetAvatar* GetPlayerByNetID(int netid)
###### • std::list<NetAvatar*> GetPlayerlist()
###### • std::list<WorldObject*> GetWorldObject()
###### • std::list<Inventory*> GetInventory()
###### • World* GetWorld()
###### • void SendVarlist(variantlist_t, int, int) // Variantlist | delay | netid
###### • void SetLocalPlayer(bool, NetAvatar) // Use cloth effect | NetAvatar structure
###### • bool ToggleCheat(std::string cheat_name, bool state)
###### • void addHook(function, std::string Hook_Name)
###### • void Log(std::string text)
###### • std::list<NPCList*> NPCList()

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
{
  int x;
  int y;
} pos;
std::string name // name of Local player
std::string country // country code of Local player
int userid // userID of Local player
int status // status of Local player
int netid // local netID
bool facing // is local player facing left
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
## Inventory
```
int id // id of item
int count // count of item
```

## ExtraTile
```
int type
int growth
int owner
std::string label // Sign, Door, Audio racks
int volume
int fruit_count
int last_update // GT Timing sh*t
```

## Tile
```
{
  int x;
  int y;
} pos;
int fg // Tile Foreground itemID
int bg // Tile Background itemID
bool readyharvest // Tile Ready harvest
ExtraTile* extra // Check if extra true before accessing, or your script will terminated;
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
int oid // object id
int invbits // unk
{
  int x;
  int y;
} pos;
```

## World
```
std::string name // current world name
```


## NPCList
```
int id // NPC ID
int type // NPC Type: Normal Ghost 1, Mind ghost 12
{
  int x;
  int y;
} current; // Current npc position in realtime
{
  int x;
  int y;
} target; // NPC will move into this target position;
```

## GameUpdatePacket
```
uint8_t type
uint8_t netid
uint8_t jump_amount
uint8_t count
int32_t playerflags
int32_t item
int32_t packetflags
float structflags
int32_t intdata
float vecx
float vecy
float vec2x
float vec2y
float particletime
uint32_t mstate1
uint32_t mstate2
uint32_t datasize
uint32_t data

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

Example script [Click me!](https://github.com/GENTA7740/GENTA-HAX-DOCS/tree/main/Example)

# Feel free to report bug mod on issue tab!
