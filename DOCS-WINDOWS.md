
# GENTA HAX - WINDOWS - LUA DOCUMENTATION!
Before we start make sure you know basic of lua scripting, you can try learn the basic [here](https://lua.org/docs.html), there will be several custom data types something like **ImVec2**, **ImVec4**, **Vector2f**, **Vector3i**, etc. Make sure you know the **basic** of lua! or you can throw away your dream of becoming a lua scripter.

Resource:

[ImGui](https://github.com/ocornut/imgui)

[Lua](https://lua.org)

[OpenSSL](https://www.openssl.org/)

[Growtopia](https://www.growtopiagame.com/)

Discord Server:
[![Discord](https://img.shields.io/discord/870604052281573406)](https://discord.gg/JTM9b6XR3A)

File Path:
#### • Script/here.lua

# Function / Method

## Getting Player
#### • NetAvatar* GetLocal()
#### • std::list<NetAvatar*> GetPlayerlist()

## Setting Player
#### • 

## Getting Player Inventory
#### • std::list<Inventory*> GetInventory()

## Setting Player Inventory
#### • 

## Getting World Info
#### • World* GetWorld()

## Setting World Info

## Getting World Tile
#### • Tile* CheckTile(int x, int y)
#### • std::vector<Tile*> GetTile()

## Setting World Tile

## Getting World Object
#### • std::list<WorldObject*> GetWorldObject()

## Setting World Object

## Getting World NPC
#### • std::list<NPCList*> GetNPC()

## Setting World NPC

## Packet Sender
#### • void SendPacket(int type, String pkt)
#### • void SendPacketRaw(int flags, TankPacketStruct packet)

## Usefull API
#### • void sleep(int sleep_in_ms)
#### • PlaySound(String m_sound_path)
#### void AddHook(GentaHook, String HookLabel, function)
#### void RemoveHooks()
#### • void RemoveHook(String HookLabel)

##  Logging
#### • void Log(String text)

## Getting ItemDB
#### • ItemInfo* GetItemByID(int itemID)

## Setting ItemDB

## Player Movement
#### • bool FindPath(int x, int y, int delay)

# Structure & Attribute

## TankPacketStruct
| Type    | PacketAttributes |
|---------|------------------|
| uint8_t | type             |
| int     | state            |
| int     | value            |
| float   | posX                |
| float   | posY                |
| float   | xspeed           |
| float   | yspeed           |
| int     | padding5         |
| int     | px           |
| int     | py           |

## NetAvatar
| Type       | Attribute     |
|------------|---------------|
 | string | name | 
 | boolean | status | 
 | number | ances | 
 | number | netid | 
 | number | necklace | 
 | number | ping | 
 | number | skin | 
 | number | day | 
 | number | mask | 
 | number | face | 
 | boolean | accountsecured | 
 | number | back | 
 | number | pants | 
 | string | role_day | 
 | string | captcha | 
 | number | level | 
 | number | feet | 
 | number | shirt | 
 | boolean | haveaccount | 
 | number | month | 
 | number | awesomeness | 
 | number | hair | 
 | number | hand | 
 | number | botid | 
 | number | gems | 
 | number | posY | 
 | number | posX | 
 | boolean | tournament | 


## World
| Type          | Attribute |
|---------------|----------------|
| String        | name           |
| uint8_t       | width          |
| uint8_t       | height         |
| int           | tilecount        |

## Tile
| Type          | Attribute |
|---------------|----------------|
| uint16_t      | fg             |
| uint16_t      | bg             |
| bool          | ready  |
| int           | x |
| int           | y |


## ItemInfo
| Type        | Attribute |
|-------------|--------------------|
| std::string | Name               |
| int         | ItemType           |
| int         | Rarity             |
| int         | Growth             |
| int 		  | Collision          |

## WorldObject
| Type    | Attribute |
|---------|-----------------------|
| int     | id                    |
| int     | amount                |
| int     | oid                   |
| int     | invbits               |
| int     | x                     |
| int     | y                 	  |


## NPCList
| Type    | Attribute |
|---------|-------------------|
| int     | id                |
| int     | type              |
| int     | c_pos_x           |
| int     | c_pos_y           |
| int     | t_pos_x           |
| int     | c_pos_y           |

## Inventory
| Type    | Attribute |
|---------|-----------|
| int     | id        |
| uint8_t | amount    |


# Genta Hook
|  GentaHook           | Parameter              |
|---------------------|------------------------|
| OnPacket        | int flag, String packet	   |
| OnVarlist           | Variantlist_t[], int netID  |
| OnProcessRaw         | TankPacketStruct raw|



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
