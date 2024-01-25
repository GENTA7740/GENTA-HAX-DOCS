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
> Example: 0.123 1.356 44.264

> uint8_t 
> unsigned integer type with width of exactly 8, 16, 32 and 64 bits respectively.
> Example: 0 - 255.

> uint32_t
> unsigned integer type with width of exactly 8, 16, 32 and 64 bits respectively.
> Example: 0 - 4294967295.

> int32_t
> signed integer type with width of exactly 8, 16, 32 and 64 bits respectively.
> with no padding bits and using 2's complement for negative values.
> Example: -2,147,483,648 - 2147483647.

> bool
> A boolean data type in lua is defined using the keyword bool. Usually, 1 ( true ) and 0 ( false ) are assigned to boolean variables as their default numerical values.
> Example: true or false, 1 as true or 0 as false.

> int 
> integer
> Example: -2147483647 - 2147483647.


> string
> String is a collection of characters.
> Example: Kontol
# API list

###### • void logToConsole(std::string)
###### • void sleep(int) // int ( Sleep time in Milliseconds )
###### • void sendPacketRaw(bool send_to_client, TankPacketStruct packet)
###### • void sendPacket(int type, std::string pkt) // Type, Packet
###### • void findPath(int x, int y, int delayMS) // delayMS is optional
###### • std::vector<Tile*> getTile()
###### • Tile* checkTile(int x, int y)
###### • ItemInfo* getItemByID(int itemID)
###### • NetAvatar* getLocal()
###### • NetAvatar* getPlayerByNetID(int netid)
###### • std::list<NetAvatar*> getPlayerlist()
###### • std::list<WorldObject*> getWorldObject()
###### • std::list<Inventory*> getInventory()
###### • void sendVariant(variantlist_t, int, int) // Variantlist | netid | delay
###### • void AddHook(GentaHook, std::string HookLabel, function)
###### • void doLog(std::string text)
###### • std::list<NPCList*> getNpc()
###### • bool toggleCheat(int cheat_code, bool state)
###### • void getCheat(int cheat_code)
###### • Vector2f getTouchAtWorldPos()
###### • Vector2f getTouchAtScreenPos()
###### • World* getWorld()
# Coming soon

###### • void setLocalPlayer(bool, NetAvatar) // Use cloth effect | NetAvatar structure


# Cheat Code
```
"Fast Fruit" = 0
"Ghost Mode" = 1
"Night Vision" 2
"Can See Ghost" = 3
"Anti Bounce" = 4
"Death Anywhere" = 5
"No Clip" = 6
"Bypass Death" = 7
"Show Door Label" = 8
"Show Sign Label" = 9
"Anti Portal" = 10
"Dev Mode" = 11
"Fast Wheel" = 12
"Real Fake Bubble" = 13
"Show Ping" = 14
"Anti State" = 15
"Anti Punch" = 16
"Path Finder" = 17
"Skip Update" = 18
"Anti Tile Activation" = 19
"Anti Respawn" = 20
"Anti Freeze State" = 21
"Can't Take Item" = 22
"Can't move" = 23
"Fast Dice" = 24
"Auto Acc" = 25
"Mod Fly = 26
```

# Structure

## Vector2f
```
float x;
float y;
```

## TankPacketStruct
```
int type // Packet type
int state // Character state
int value // Value
int x // Player Position X
int y // Player Position Y
int speedx // player X speed
int speedy // player Y speed
int tilex // Punch X
int tiley // Punch Y
int netid // NetID
```

## NetAvatar
```
{
  int x;
  int y;
} pos;
std::string name // name of Local player
std::string country // country code of Local player
int userId // userID of Local player
int status // status of Local player
int netId // local netID
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
int ping // Peer roundtrip
int punchId // local punch id
int gemsCollected // unknown
int gems // local gems count
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
int flags
bool ready // ready harvest / no
std::string label // Sign, Door, Audio racks
int volume
int fruitCount
int lastUpdate // GT Timing sh*t
```

## Tile
```
{
  int x;
  int y;
} pos;
int fg // Tile Foreground itemID
int bg // Tile Background itemID
```

## ItemInfo
```
std::string name // Name of item
int type // Item Type
int rarity // Item Rarity
int growth // item growt time
```

## WorldObject
```
int id // item id
int amount // item amount
int oid // object id
int flags // unk
{
  int x;
  int y;
} pos;
```

## World
```
std::string name // current world name
int height
int width
int lastOid
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

# GentaHook
###### • OnTextPacket // Game Text Packet
###### • OnVarlist // Variant list Hook
###### • OnTouch // Hook Handle Touch At World Pos
###### • OnRender // Hook OpenGL 3.0 renderer ( ImGui Renderer Coming soon )
###### • OnRawPacket // Game Packet Raw
###### • OnGameUpdatePacket // Hook Game Update Packet


# GentaHook Parameter

## OnTextPacket
###### • bool onTextPacketHook(int type, const std::string& packet);
## OnVarlist
###### • bool onVarlist(variantlist_t var, int netid);
## OnTouch
###### • void onTouch(int touchX, int touchY);

# COMING SOON ( MAYBE )
## OnRender
###### • void onRender(int isRendering);
## OnPacketRaw
###### • bool onPacketRaw(TankPacketStruct raw, int type, size_t size, int flags);
## OnGameUpdatePacket
###### • bool onGameUpdatePacket(TankPacketStruct raw);

# Example

Example script [Click me!](https://github.com/GENTA7740/GENTA-HAX-DOCS/tree/main/Example)

# Feel free to report bug mod on issue tab!
