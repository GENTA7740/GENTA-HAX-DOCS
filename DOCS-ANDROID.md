# GENTA HAX - WINDOWS & ANDROID - LUA DOCUMENTATION!
Before we start make sure you know basic of lua scripting, you can try learn the basic [here](https://lua.org/docs.html), there will be several custom data types something like **ImVec2**, **ImVec4**, **Vector2f**, **Vector3i**, etc. Make sure you know the **basic** of lua! or you can throw away your dream of becoming a lua scripter.

Resource:

[ImGui](https://github.com/ocornut/imgui)

[Lua](https://lua.org)

[OpenSSL](https://www.openssl.org/)

[Growtopia](https://www.growtopiagame.com/)

Discord Server:
[![Discord](https://img.shields.io/discord/870604052281573406)](https://discord.gg/JTM9b6XR3A)

File Path:
#### • Android/media/GENTAHAX/Script/here.lua

# Function / Method

## Getting Player
#### • NetAvatar* getLocal()
#### • NetAvatar* getPlayerByNetID(int netid)
#### • std::list<NetAvatar*> getPlayerlist()

## Setting Player
#### • ~~void setPlayer(NetAvatar*)~~

## Getting Player Inventory
#### • std::list<Inventory*> getInventory()

## Setting Player Inventory
#### • ~~void addItem(int itemID, uint8_t amount)~~

## Getting World Info
#### • World* getWorld()

## Setting World Info

## Getting World Tile
#### • Tile* checkTile(int x, int y)
#### • std::vector<Tile*> getTile()
#### • TileExtra* getExtraTile(int x, int y)

## Setting World Tile

## Getting World Object
#### • std::list<WorldObject*> getWorldObject()

## Setting World Object

## Getting World NPC
#### • std::list<NPCList*> getNpc()

## Setting World NPC

## Getting Game Touch
#### • Vector2f getTouchAtScreenPos()
#### • Vector2f getTouchAtWorldPos()

## Setting Game Touch


## Getting Game Camera
#### • Camera* getCamera()
#### • Vector2f worldToScreen(float x, float y)

## Setting Game Camera
#### • void setCamera(float x, float y)

## Getting Device Info
#### • String getMac()
#### • String getGid()

## Setting Device Info
#### • void randomGid()
#### • void randomMac()
#### • void setGid(String newGoogleID) : max 37 character.
#### • void setMac(String newMac) : max 18 character.

## Packet Sender
#### • void sendPacket(int type, String pkt)
#### • void sendPacketRaw(bool send_to_client, TankPacketStruct packet)
#### • void sendVariant(variantlist_t var, int netID, int delay)

## Getting System Timing
#### • unsigned long getCurrentTimeInternal()

## Usefull API
#### • void arrowToItem(bool isFloatingObject, int itemID_Target)
#### • std::string getDiscordID()
#### • bool checkPath(int x, int y)
#### • void requestCollect(int x, int y, int itemID)
#### • void requestTileChange(int x, int y, int item_id)
#### • void AddHook(GentaHook, String  HookLabel, function)
#### • void RemoveHooks()
#### • void RemoveHook(String HookLabel)
#### • void sleep(int sleep_in_ms)
#### • void doToast(int toastType, int dissMissTimeInMilliSeconds, String text)
#### • void callToast(String text, int type) // type = 1: Long time, type = 0: Short time. ( Based on Java Toast. )
#### • Vector2f getScreenSize()
#### • void runThread(function(), [optional] String thread_label)
#### • void killAllThread()
#### • void killThread(String thread_label)
#### • int hash32(String) -- Returning a 32 bit int (uint32_t) hashes.
#### • int hash64(String) -- Returning a 64 bit int (uint64_t) hashes.

##  Logging
#### • void logToConsole(String text)
#### • void doLog(String text)
#### • void doLogError(String text) : Logcat level logging
#### • void doLogInfo(String text) : Logcat level logging

##  Connection
#### • void sendWebhook(String  url, DiscordWebhook)
#### • Response makeRequest(String  url, String method, std::list<String> header, String body, int connection_time_out) 

## Getting ItemDB
#### • ItemInfo* getItemByID(int itemID)
#### • ItemInfo* getItemByName(String itemName)

## Setting ItemDB

## Getting Cheats
#### • bool getCheat(int cheat_code)

## Setting Cheats
#### • void toggleCheat(int cheat_code, bool state)

## Player Movement
#### • bool findPath(int x, int y)

# Structure & Attribute

## TankPacketStruct
| Type    | PacketAttributes |
|---------|------------------|
| uint8_t | type             |
| uint8_t | padding1         |
| uint8_t | padding2         |
| uint8_t | padding3         |
| int     | netid            |
| int     | secid            |
| int     | state            |
| float   | padding4         |
| int     | value            |
| float   | x                |
| float   | y                |
| float   | speedx           |
| float   | speedy           |
| int     | padding5         |
| int     | punchx           |
| int     | punchy           |

## Response
| Type    | CameraAttributes |
|---------|------------------|
| String  | content          |

## Camera
| Type    | CameraAttributes |
|---------|------------------|
| float   | scale            |
| Vector2f| pos              |
| Vector2f| center           |


## NetAvatar
| Type       | Attribute     |
|------------|---------------|
| Vector2i   | pos           |
| std::string| name          |
| std::string| country       |
| int        | userId        |
| int        | status        |
| int        | netId         |
| bool       | facing        |
| uint32_t   | hair          |
| uint32_t   | shirt         |
| uint32_t   | pants         |
| uint32_t   | feet          |
| uint32_t   | face          |
| uint32_t   | hand          |
| uint32_t   | back          |
| uint32_t   | mask          |
| uint32_t   | necklace      |
| int        | ping          |
| uint8_t    | punchId       |
| int        | gemsCollected |
| int        | gems          |
| Vector4i   | skinColor     |
| Vector4i   | quickSlot     |
| int        | backpackSlot  |
| uint32_t   | selectedItem  |

## TileExtra
| Type          | Attribute |
|---------------|---------------------|
| bool          | valid               |
| int           | type                |
| int           | growth              |
| int           | owner               |
| int           | flags               |
| std::list<uint32_t> | adminList   |
| bool          | ready               |
| std::string   | label               |
| std::string   | padding1            |
| int           | volume              |
| int           | fruitCount          |
| int           | lastUpdate          |

## World
| Type          | Attribute |
|---------------|----------------|
| String        | name           |
| uint8_t       | width          |
| uint8_t       | height         |
| int           | lastOid        |

## Tile
| Type          | Attribute |
|---------------|----------------|
| Vector2i      | pos            |
| uint16_t      | fg             |
| uint16_t      | bg             |
| bool          | isCollideable  |
| int           | collisionType  |
| int           | flags          |
| TileFlag      | getFlags       |

## TileFlag
| Type | Attribute |
|------|--------------------|
| bool | locked             |
| bool | area               |
| bool | flipped            |
| bool | enabled            |
| bool | public             |
| bool | silenced           |
| bool | water              |
| bool | glue               |
| bool | burn               |
| bool | painted            |

## ItemInfo
| Type        | Attribute |
|-------------|--------------------|
| std::string | name               |
| int         | actionType         |
| int         | rarity             |
| int         | growth             |
| std::string | texture            |
| std::string | texture_2          |
| int         | editableType       |
| int         | collisionType      |
| int         | itemCategory       |
| Vector2i    | texturePos         |
| int         | clothType          |
| int         | blockType          |
| int         | hitSoundType       |

## WorldObject
| Type    | Attribute |
|---------|-----------------------|
| int     | id                    |
| int     | amount                |
| int     | oid                   |
| int     | flags                 |
| Vector2i| pos                   |

## World
| Type        | Attribute |
|-------------|-----------------|
| std::string | name            |
| int         | height          |
| int         | width           |
| int         | lastOid         |


## NPCList
| Type    | Attribute |
|---------|-------------------|
| int     | id                |
| int     | type              |
| Vector2i| current           |
| Vector2i| target            |

## Inventory
| Type    | Attribute |
|---------|-----------|
| int     | id        |
| uint8_t | amount    |

## Vector2i or Vector2f
| Type | Attribute |
|------|------------|
| int or float  | x          |
| int or float  | y          |

## Vector3i or Vector3f
| Type | Attribute |
|------|-----------|
| int or float | x  |
| int or float | y  |
| int or float | z  |

## Vector4i or Vector4f
| Type | Attribute |
|------|-----------|
| int or float | w  |
| int or float | x  |
| int or float | y  |
| int or float | z  |

# Genta Hook
|  GentaHook           | Parameter              |
|---------------------|------------------------|
| OnTextPacket        | int flag, String packet	   |
| OnVarlist           | Variantlist_t[], int netID  |
| OnTouch             | float x, float y    |
| OnRender            | int deltaTime    	|
| OnRawPacket         | TankPacketStruct raw|
| OnGameUpdatePacket  | TankPacketStruct raw|
| OnENetInit		  | String ip, int port	|


# Discord Webhook

## EmbedAuthor
| Type        | Attribute |
|-------------|-----------------------|
| std::string | name                  |
| std::string | url                   |
| std::string | icon_url              |

## EmbedField
| Type        | Attribute |
|-------------|----------------------|
| std::string | name                 |
| std::string | value                |
| bool        | inline               |

## EmbedURL
| Type        | Attribute |
|-------------|--------------------|
| std::string | url                |

## EmbedFooter
| Type        | Attribute |
|-------------|-----------------------|
| std::string | text                  |
| std::string | icon_url              |

## EmbedBuilder
| Type               | Attribute |
|--------------------|------------------------|
| EmbedAuthor        | author                 |
| std::string        | title                  |
| std::string        | url                    |
| std::string        | description            |
| std::string        | color                  |
| std::list<EmbedField> | fields              |
| EmbedURL           | thumbnail              |
| EmbedURL           | image                  |
| EmbedFooter        | footer                 |

## DiscordWebhook
| Type               | Attribute |
|--------------------|---------------------------|
| std::string        | username                  |
| std::string        | avatar_url                |
| std::string        | content                   |
| bool               | useEmbeds                 |
| EmbedBuilder       | embeds                    |


# Enum

## CheatCode
| Label                 | Value |
|-----------------------|-------|
| Fast Fruit            | 0     |
| Ghost Mode            | 1     |
| Night Vision          | 2     |
| Can See Ghost         | 3     |
| Anti Bounce           | 4     |
| Death Anywhere        | 5     |
| No Clip               | 6     |
| Bypass Death          | 7     |
| Show Door Label       | 8     |
| Show Sign Label       | 9     |
| Anti Portal           | 10    |
| Dev Mode              | 11    |
| Fast Wheel            | 12    |
| Real Fake Bubble      | 13    |
| Show Debug            | 14    |
| Anti State            | 15    |
| No Particle           | 16    |
| Path Finder           | 17    |
| Skip Update           | 18    |
| Anti Tile Activation  | 19    |
| Anti Respawn          | 20    |
| Anti Freeze State     | 21    |
| Can't Take Item       | 22    |
| Can't move            | 23    |
| Fast Dice             | 24    |
| Auto Acc              | 25    |
| Mod Fly               | 26    |
| Extractor Dynamo      | 27    |
| Anti OnKilled         | 28    |
| No Render Image       | 29    |
| Free Camera           | 30    |
| Show Ready Harvest    | 31    |

## Toast Type
| Flags                | Value |
|--------------------------------|-------|
| ImGuiToastType_None      | 0     |
| ImGuiToastType_Success   | 1     |
| ImGuiToastType_Warning   | 2     |
| ImGuiToastType_Error | 3 |
| ImGuiToastType_Info          | 4     |


## ENet Packet Flag
| Flags                | Value |
|--------------------------------|-------|
| ENET_PACKET_FLAG_RELIABLE      | 0     |
| ENET_PACKET_FLAG_UNSEQUENCED   | 1     |
| ENET_PACKET_FLAG_NO_ALLOCATE   | 2     |
| ENET_PACKET_FLAG_UNRELIABLE_FRAGMENT | 3 |
| ENET_PACKET_FLAG_SENT          | 8     |

## Growtopia Raw Packet Type
| Packet Type                       | Value |
|-----------------------------------|-------|
| PACKET_STATE                      | 0     |
| PACKET_CALL_FUNCTION              | 1     |
| PACKET_UPDATE_STATUS              | 2     |
| PACKET_TILE_CHANGE_REQUEST        | 3     |
| PACKET_SEND_MAP_DATA              | 4     |
| PACKET_SEND_TILE_UPDATE_DATA      | 5     |
| PACKET_SEND_TILE_UPDATE_DATA_MULTIPLE | 6 |
| PACKET_TILE_ACTIVATE_REQUEST      | 7     |
| PACKET_TILE_APPLY_DAMAGE          | 8     |
| PACKET_SEND_INVENTORY_STATE       | 9     |
| PACKET_ITEM_ACTIVATE_REQUEST      | 10    |
| PACKET_ITEM_ACTIVATE_OBJECT_REQUEST | 11  |
| PACKET_SEND_TILE_TREE_STATE       | 12    |
| PACKET_MODIFY_ITEM_INVENTORY      | 13    |
| PACKET_ITEM_CHANGE_OBJECT         | 14    |
| PACKET_SEND_LOCK                  | 15    |
| PACKET_SEND_ITEM_DATABASE_DATA    | 16    |
| PACKET_SEND_PARTICLE_EFFECT       | 17    |
| PACKET_SET_ICON_STATE             | 18    |
| PACKET_ITEM_EFFECT                | 19    |
| PACKET_SET_CHARACTER_STATE        | 20    |
| PACKET_PING_REPLY                 | 21    |
| PACKET_PING_REQUEST               | 22    |
| PACKET_GOT_PUNCHED                | 23    |
| PACKET_APP_CHECK_RESPONSE         | 24    |
| PACKET_APP_INTEGRITY_FAIL         | 25    |
| PACKET_DISCONNECT                 | 26    |
| PACKET_BATTLE_JOIN                | 27    |
| PACKET_BATTLE_EVEN                | 28    |
| PACKET_USE_DOOR                   | 29    |
| PACKET_SEND_PARENTAL              | 30    |
| PACKET_GONE_FISHIN                | 31    |
| PACKET_STEAM                      | 32    |
| PACKET_PET_BATTLE                 | 33    |
| PACKET_NPC                        | 34    |
| PACKET_SPECIAL                    | 35    |
| PACKET_SEND_PARTICLE_EFFECT_V2    | 36    |
| GAME_ACTIVE_ARROW_TO_ITEM         | 37    |
| GAME_SELECT_TILE_INDEX            | 38    |
