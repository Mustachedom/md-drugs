# 🌿 MD-Drugs – Advanced Drug System for FiveM

A fully customizable, immersive drug system for FiveM servers.

<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img src="https://i.imgur.com/t65G9Z0.png" width="200" alt="Mustache Scripts Logo">
  </a>
  <br>
  <a href="https://discord.gg/sAMzrB4DDx"><strong>Join Mustache Scripts Discord</strong></a>
</div>

---

- **[Samuel's Development](https://fivem.samueldev.shop/  ):** Used their Christmas script global states and prop spawning (with permission).  
- **[STACHY225](https://babiczind.tebex.io/category/2103836  ):** Meth network animations.  
- **[Bostra](https://discord.gg/5ncbwMNq  ):** Free scripts, sanity checks, and those cute mushrooms!  
- **[Feisty]():** Stunning visuals that make everything look amazing.  
- **Beta Testers:** Your invaluable feedback made this possible.  
- **[1of1 Servers](https://1of1servers.com/  ):** Top-notch hosting and support. Join their [Discord](https://discord.gg/1of1servers  ).  
- **[Kamaryn](https://discord.gg/KPRmZqFS  ):** For the [installation guide video](https://youtu.be/zvuYnUfrqaA?si=FGJuBO5krZMC14Nd).  
- **[Athena](https://discord.gg/mam8Nmg49d):** For the Balloon props :)
## 🎬 Preview

🎥 **[Watch Full Preview Video](https://www.youtube.com/watch?v=I_x7_oz_SAU)**


---

## 📦 Dependencies

| Dependency | Link |
|----------|------|
| `ps_lib` | [GitHub - Project-Sloth/ps_lib](https://github.com/Project-Sloth/ps_lib) |
| `Read`   | [Read Docs](https://letters.hookedonphonics.com/us/read-guaranteed-G14.html) |
| Game Build | **2944 or later** required |

> ⚠️ Ensure all dependencies are installed and up to date before proceeding.

---

## 🛠️ Installation

### Step 1: Inventory Integration

#### For QBCore (`qb-inventory`)
1. Copy items from `md-drugs/items_install/qb-inventory` into `qb-core/shared/items.lua`.
2. Add item images from `md-drugs/items_install/images` to `qb-inventory/html/images`.

#### For OX_Inventory
1. Copy items from `md-drugs/items_install/ox_inventory` into `ox_inventory/data/items.lua`.
2. Add item images to `ox_inventory/web/images`.

---

### Step 2: Configure Drug Locations & Recipes

- All **processing locations and recipes** are located in their respective drug type files:
  - `cocaine.lua`,
  - `meth.lua`,
  - `weed.lua`,
  - etc.
- **Plant spawns** are managed in `server/plantSpawns.lua`.

> ✏️ Modify these files to customize spawn points, yields, and processing times.

---
### STEP 3
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


### STEP 4 (IF QBCore)
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
	
### STEP 5
- Run SQL
    - if you dont know how, click this image below
        - [![YouTube Video](https://img.youtube.com/vi/8QpFOluK_xo/hqdefault.jpg)](https://www.youtube.com/watch?v=8QpFOluK_xo)

### STEP 6 
    - If you want whippits, take the folder `ate_balloon` and place that folder into the standalone folder like it was another script :) (or a [props] if you got it)