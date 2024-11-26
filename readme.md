# MD-Drugs 

<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://i.imgur.com/t65G9Z0.png" width="200">
  </a><br>
  <a href="https://discord.gg/sAMzrB4DDx"><strong>Mustache Scripts Discord</strong></a><br>
</div>

## **Credits**

- **[Samuel's Development](https://fivem.samueldev.shop/):** Used their Christmas script global states and prop spawning (with permission).  
- **[STACHY225](https://babiczind.tebex.io/category/2103836):** Meth network animations.  
- **[Bostra](https://discord.gg/5ncbwMNq):** Free scripts, sanity checks, and those cute mushrooms!  
- **[Feisty]():** Stunning visuals that make everything look amazing.  
- **Beta Testers:** Your invaluable feedback made this possible.  
- **[1of1 Servers](https://1of1servers.com/):** Top-notch hosting and support. Join their [Discord](https://discord.gg/1of1servers).  
- **[Kamaryn](https://discord.gg/KPRmZqFS):** For the [installation guide video](https://youtu.be/zvuYnUfrqaA?si=FGJuBO5krZMC14Nd).  


## **Dependencies**

- **[ox_lib](https://github.com/overextended/ox_lib/releases/tag/v3.12.0)**  
- **[qb-target](https://github.com/qbcore-framework/qb-target)** or **[ox_target](https://github.com/overextended/ox_target)**  
- **Emote Scripts (supports animations):**
  - [dpemotes](https://github.com/andristum/dpemotes)  
  - [rpemotes](https://github.com/alberttheprince/rpemotes-reborn)  
  - [scully_emotemenu](https://github.com/Scullyy/scully_emotemenu)  
- **[Read](https://letters.hookedonphonics.com/us/read-guaranteed-G14.html)**  
- **Game Build 2944 or Later**



## **Preview**

- **[Watch Preview](https://www.youtube.com/watch?v=I_x7_oz_SAU)**


##  **How to install like a fuckin boss**

### STEP 1

- qb-inventory users go to md-drugs/items_install/qb-inventory and add the Items to `qb-core/shared/items.lua` and - Add items from md-drugs/items_install/images to qb-inventory/html/images
- ox_inventory users go to md-drugs/items_install/ox_inventory and add the Items to `ox_inventory/data/items.lua` and - Add items from md-drugs/items_install/images to ox_inventory/web/images

### STEP 2
- delete `qb-drugs` 

### STEP 3
- all locations, shops, pricings, and recipes are in the server files now utilizing callbacks to build targets and retrieve data
    - shops.lua
        - travelling merchant
        - Weed Store
        - Dealer Shops
    - locations.lua
        - holds all old config options for locations. edit what you need in here
            - if you previously had them in the config copy and paste the <strong> INTERIOR </strong> guts of the options. example below
                ```lua
                    Config.MakePowder = {
                         {loc = vector3(1086.20, -3195.30, -39.20), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
                         {loc = vector3(1090.15, -3199.5, -39.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
                         {loc = vector3(1093.09, -3199.53, -39.05), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
                    }
                ```
                is now
                ```lua
                local Target = {
                    MakePowder = {
                        {loc = vector3(1086.20, -3195.30, -39.20), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
                        {loc = vector3(1090.15, -3199.5, -39.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
                        {loc = vector3(1093.09, -3199.53, -39.05), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
                    }
                }
                ```
                - see its a simple change.
    - recipes.lua
        - handles the vast majority of remove X get Y
    - Cornerselling.lua
        - now the drug table is inserted into this file. 
            - copy and paste your data inside of the 
            ```lua
                local Drugs = {

                }
            ```
    - all plant locations i.e. coke, heroin, weed, shrooms, mescaline are in the respective server files
### STEP 4
 - Head to your emote script search for **uncuff** if it's missing add it
    - if rpemotes do this 
        - go to client/animationListCustom.lua 
            - add these to the CustomDP.Emotes = {}
            ```lua
                ["uncuff"] = {"mp_arresting","a_uncuff","Uncuff", AnimationOptions = {     EmoteLoop = true,     EmoteMoving = true } },
                ["edible"] = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "edible",    AnimationOptions = {        EmoteLoop = false,        EmoteMoving = true    }},
            ```
            - Add This to CustomDP.PropEmotes = {}
            ```lua
                ["shootup"] = { "rcmpaparazzo1ig_4", "miranda_shooting_up", "Shoot Up",  AnimationOptions = {EmoteLoop = true,EmoteMoving = true,Prop = 'prop_syringe_01',  PansexualPropBone = 18905,PropPlacement = {0.11, 0.03, 0.0, -124.0, 0.0, 0.0},}}
            ```
    - elseif dpemotes add this to client/AnimationList.lua
        - add these to DP.Emotes = {}
           ```lua
                ["uncuff"] = {"mp_arresting","a_uncuff","Uncuff", AnimationOptions = {     EmoteLoop = true,     EmoteMoving = true } },
                ["edible"] = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "edible",    AnimationOptions = {        EmoteLoop = false,        EmoteMoving = true    }},
            ```
        - add these to DP.PropEmotes = {}
             ```lua
                ["shootup"] = { "rcmpaparazzo1ig_4", "miranda_shooting_up", "Shoot Up",  AnimationOptions = {EmoteLoop = true,EmoteMoving = true,Prop = 'prop_syringe_01',  PansexualPropBone = 18905,PropPlacement = {0.11, 0.03, 0.0, -124.0, 0.0, 0.0},}}
            ```
    - elseif scullyemotes then 
        - add this to emotes.lua
            ```lua
		        {
		        	Label = 'Uncuff',
		        	Command = 'uncuff',
		        	Animation = 'a_uncuff',
		        	Dictionary = 'mp_arresting',
		        	Options = {
		        		Flags = {
		        			Loop = true,
		        			Move = true,
		        		},
		        	}
		        },
		        {
		        	Label = 'Edibles',
		        	Command = 'edible',
		        	Animation = 'mp_player_int_eat_burger',
		        	Dictionary = 'mp_player_inteat@burger',
		        	Options = {
		        		Flags = {
		        			Loop = true,
		        			Move = true,
		        		},
		        	}
		        },
            ```
        - then in prop emotes do 
            ```lua
            {
                    Label = 'Shoot Up',
                    Command = 'shootup',
                    Animation = "miranda_shooting_up",
                    Dictionary = "rcmpaparazzo1ig_4",
                    Options = {
                        Flags = {
                            Loop = true,
                        },
                        Props = {
                            {
                                Bone = 18905,
                                Name = 'prop_syringe_01',
                                Placement = {
                                    vector3(0.11, 0.03, 0.0),
                                     vector3( -124.0, 0.0, 0.0),
                                },
                            },
                        },
                    },
                },
            ```


# STEP 5
- check `qb-smallresources/config.lua` and if this exists, delete it 
    - look for this code
        ```lua
        [2] = { --Coke Processing Enter/Exit
                [1] = {
                    poly = { coords = vector3(909.49, -1589.22, 30.51), heading = 92.24, length = 2, width = 2 },
                    allowVeh = false,
                    label = '[E] Enter Coke Processing'
                },
                [2] = {
                    poly = { coords = vector3(1088.81, -3187.57, -38.99), heading = 181.7, length = 2, width = 2 },
                    allowVeh = false,
                    label = '[E] Leave'
                }
            }
        ```
	
# STEP 6
- Run SQL


# **OPTIONAL STEPS**

## Fivemerr
This is **NOT** a requirement but something I personally use and believe in.


- to integrate with fivemerr make sure you have  ```set fivemerrLogs "API_KEY"```   in your server.cfg
   
- Head to /server/functions.lua turn local logs = true
  
- profit

<b>Why Integrate with Fivemerr?</b>

- Efficient Logging: Unlike Discord webhooks, Fivemerr provides an organized and searchable log system.
- Media Storage: Easily store and access images or videos without relying on Discord. Discord's API often deletes media after a certain time, but Fivemerr keeps them secure and accessible.
- As well as a place to offload images and videos from fivem that doesnt rely on discord since discord API will be automatically deleting images and videos after a certain amount of time If you need an invite to their server look below

[Fivemerr Discord](https://discord.com/invite/fivemerr)

[Fivemerr Docs](https://docs.fivemerr.com/)

## Radial Menu
- head to `qb-radial/config.lua` and search for the following event
```lua
     event = 'qb-drugs:client:cornerselling',
```
- and change it to this
```lua
     event = 'md-drugs:client:cornerselling',
```


## For Qb-shops users

- Head to `qb-shops/config.lua` **Config.Products** and add the folowing items to OR anywhere else you want them. The Only way in this script to get them is to find the travelling merchant

```lua
	{name = 'bakingsoda',   price = 100,   amount = 5000, info = {}, type = 'item'},
	{name = 'emptyvial',    price = 100,   amount = 5000, info = {}, type = 'item'},
	{name = 'needle',    	price = 100,   amount = 5000, info = {}, type = 'item'},
```

## Tier System
- Turn On Config.TierSystem after you run the sql file

[mlo i use](https://www.gta5-mods.com/maps/mlo-4x-drug-lab-interiors-sp-fivem) heres an option. use it or dont. 
