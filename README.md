[![Discord](https://img.shields.io/discord/870604052281573406)](https://discord.gg/JTM9b6XR3A)
## GentaHax Script Documentation
this documentation will teach you how to make script for GentaHax
## Requirements
- You must know basic lua scripts.
- You must have Genta Hax :v
- Lua programming basic knowledge [Lua site](https://lua.org)

[ImGui Documentation](https://github.com/ocornut/imgui)

## File Path
```
Android/media/GENTAHAX/Script/here.lua
```

# Basic Knowledge
> float
> Float is a shortened term for "floating point." By definition, it's a fundamental data type built into the compiler that's used to define numeric values with floating decimal points.
> Limitation: 1.175494351E - 38 - 3.402823466E + 38

> double
> Double is a shortened term for "doubled point." By definition, it's a fundamental data type built into the compiler that's used to define numeric values with floating decimal points.
> Limitation: 2.2250738585072014E - 308 - 1.7976931348623158 E + 308

> uint8_t 
> unsigned integer type with width of exactly 8 bits respectively.
> Limitation: 0 - 255.

> uint16_t
> unsigned integer type with width of exactly 8, and 16 bits respectively.
> Limitation: −32,768 - 32,767.

> int32_t
> signed integer type with width of exactly 8, 16 and 32 bits respectively.
> with no padding bits and using 2's complement for negative values.
> Limitation: -2,147,483,648 - 2,147,483,647.

> int64_t
> signed long integer type with width of exactly 8, 16, 32 and 64 bits respectively.
> with no padding bits and using 2's complement for negative values.
> Limitation: -9,223,372,036,854,775,808 - 9,223,372,036,854,775,807.

> bool
> A boolean data type in lua is defined using the keyword bool. Usually, 1 ( true ) and 0 ( false ) are assigned to boolean variables as their default numerical values.
> Limitation: true and false or 1 as true and 0 as false.
```
toggleCheat(26, false) -- Turning off cheat Mod fly.
```
> int 
> integer
> Limitation: -2147483647 - 2147483647.
> Example:
```
toggleCheat(26, true) -- Turning on cheat Mod fly.
```

> std::string
> std::string is a collection of characters.
> Example:
```
doLog("Hello world!")
```

> std::list or std::vector
> std::list and std::vector is a table
> Example:
```
fields = {
  {
      name = "Text",
      value = "More text",
      inline = true
  },
  {
      name = "Even more text",
      value = "Yup",
      inline = true
  },
  {
      name = "Use `\"inline\": true` parameter, if you want to display fields in the same line.",
      value = "okay..."
  },
  {
      name = "Thanks!",
      value = "You're welcome :wink:"
  }
}
```
# API list

###### • int getSignal() // Get current geiger signal.
```
0 = None
1 = Red
2 = Yellow
3 = Green
4 = Radio Active ( You found the item )
```
###### • void arrowToItem(bool isFloatingObject, int itemID_Target)
###### • std::string getDiscordID()
###### • bool checkPath(x, y) // Check if there's a way into target position.
###### • void sendWebhook(std::string url, DiscordWebhook) // Send Discord Webhook.
###### • Response makeRequest(string url [, string method][, table options][, string post_fields][, int connection_time_out]) // Credit: BotHax YT
###### • void getMac()
###### • void getGid()
###### • void requestCollect(x, y, itemID) // untested.
###### • int64_t getCurrentTimeInternal() // return current internal time in milliseconds.
###### • void randomMac()
###### • void randomGid()
###### • void setMac(std::string) // it has max 18 character.
###### • void setGid(std::string) // it has max 37 character.
###### • void logToConsole(std::string)
###### • void sleep(int) // int ( Sleep time in Milliseconds )
###### • void sendPacketRaw(bool send_to_client, TankPacketStruct packet)
###### • void requestTileChange(int x, int y, int item_id)
###### • void sendPacket(int type, std::string pkt) // Type, Packet
###### • bool findPath(int x, int y) // it will return true if Success finding a path.
###### • std::vector<Tile*> getTile()
###### • TileExtra* getExtraTile(int x, int y)
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
###### • void toggleCheat(int cheat_code, bool state)
###### • bool getCheat(int cheat_code)
###### • Vector2f getTouchAtWorldPos()
###### • Vector2f getTouchAtScreenPos()
###### • World* getWorld()
###### • Camera* getCamera()
###### • void worldToScreen(float x, float y) // Set your camera into specific position.
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


## EmbedAuthor
```
std::string name,
std::string url,
std::string icon_url
```

## EmbedAuthor
```
std::string name,
std::string url,
std::string icon_url
```

## EmbedField
```
std::stringname;
std::string value;
bool inline;
```

## EmbedURL
```
std::string url
```

## EmbedURL
```
std::string url
```

## EmbedFooter
```
std::string text;
std::string icon_url;
```

## EmbedBuilder
```
EmbedAuthor author;
std::string title;
std::string url;
std::string description;
std::string color = 15258703;
std::list<EmbedField> fields;
EmbedURL thumbnail;
EmbedURL image;
EmbedFooter footer;
```

## DiscordWebhook
```
std::string username, avatar_url, content;
bool useEmbeds // make it true if you want use embeds.
EmbedBuilder embeds;
```
## Response
```
string content
```

## Vector2i
```
int x;
int y;
```

## Vector3i
```
int x;
int y;
int z;
```

## Vector4i
```
int w;
int x;
int y;
int z;
```

## Vector2f
```
float x;
float y;
```

## Vector3f
```
float x;
float y;
float z;
```

## Vector4f
```
float w;
float x;
float y;
float z;
```

## Camera
```
float scale; // Camera Scale factors
Vector2f pos; // Current realtime camera position
Vector2f center; // Center offset of camera
```

## TankPacketStruct
```
uint8_t type // Packet type
uint8_t padding1
uint8_t padding2
uint8_t padding3
int netid // NetID
int secid // Secondary NetID
int state // Character state
float padding4
int value // Value
float x // Player Position X
float y // Player Position Y
float speedx // player X speed
float speedy // player Y speed
int padding5
int punchx // Punch X
int punchy // Punch Y
```

## NetAvatar
```
Vector2i pos;
std::string name // name of Local player
std::string country // country code of Local player
int userId // userID of Local player
int status // status of Local player
int netId // local netID
bool facing // is local player facing left
uint32_t hair // hair of Local player
uint32_t shirt // shirt of Local player
uint32_t pants // pants of Local player
uint32_t feet // feet of Local player
uint32_t face // face of Local player
uint32_t hand // hand of Local player
uint32_t back // back of Local player
uint32_t mask // mask of Local player
uint32_t necklace // necklace of Local player
int ping // Peer roundtrip
uint8_t punchId // local punch id
int gemsCollected // unknown
int gems // local gems count
Vector4i skinColor // w = alpha, x = red, y = green, z = blue;
Vector4i quickSlot // w = slot 1, x = slot 2, y = slot 3, z = slot 4;
int backpackSlot
uint32_t selectedItem // current selected item in inventory.
```

## Inventory
```
int id // id of item
int count // count of item
```

## TileExtra
```
bool valid // if there's tile extra data it will return true.
int type
int growth
int owner
int flags
std::list<uint32_t> adminList
bool ready // ready harvest / no
std::string label // Sign, Door, Audio racks
std::string padding1
int volume
int fruitCount
int lastUpdate // GT Timing sh*t
```

## Tile
```
Vector2i pos;
uint16_t fg // Tile Foreground itemID
uint16_t bg // Tile Background itemID
bool isCollideable
int collisionType
int flags -- raw tile flag's
TileFlag getFlags -- serialized tile flag's
```

## TileFlag
```
bool locked
bool area
bool flipped
bool enabled
bool public
bool silenced
bool water
bool glue
bool burn
bool painted
```

## ItemInfo
```
std::string name // Name of item
int actionType
int rarity
int growth
std::string texture // Main Texture
std::string texture_2 // Alternative Texture?
int editableType
int collisionType
int itemCategory
Vector2i texturePos // Texture pixel position
int clothType
int blockType
int hitSoundType
```

## WorldObject
```
int id // item id
int amount // item amount
int oid // object id
int flags // unk
Vector2i pos
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
Vector2i current; // Current npc position in realtime
Vector2i target; // NPC will move into this target position;
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
###### • OnRender // Hook OpenGL 3.0 renderer
###### • OnRawPacket // Game Packet Raw
###### • OnGameUpdatePacket // Hook Game Update Packet


# GentaHook Parameter

## OnTextPacket
###### • bool onTextPacketHook(int type, const std::string& packet);
## OnVarlist
###### • bool onVarlist(variantlist_t var, int netid);
## OnTouch
###### • void onTouch(int touchX, int touchY);
## OnPacketRaw
###### • bool onPacketRaw(TankPacketStruct raw);
## OnGameUpdatePacket
###### • bool onGameUpdatePacket(TankPacketStruct raw);
## OnRender
###### • void onRender(long deltaTime);
Parameter deltaTime is measure how long game render new frame from last rendered frame in milliseconds.

# COMING SOON ( MAYBE )



# Example

Example script [Click me!](https://github.com/GENTA7740/GENTA-HAX-DOCS/tree/main/example)

# Feel free to report bug mod on issue tab!
