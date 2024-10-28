# MD-Drugs 

<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://i.imgur.com/t65G9Z0.png" width="100">
  </a><br>
  <a href="https://discord.gg/sAMzrB4DDx">Mustache Scripts Discord</a><br>
</div>

# Credits

- I used [Samuel's development](https://fivem.samueldev.shop/) Christmas script global states and prop spawning (with permission obtained prior to release) in the development process.

- Shout out to [STACHY225](https://babiczind.tebex.io/category/2103836) for working out the meth network animations!

- Huge credit to [Bostra](https://discord.gg/5ncbwMNq) for sharing free scripts and providing sanity checks during moments of confusion. Those cute mushrooms? His creation!

- Special thanks to [Feisty]() for the stunning visuals. If it looks good, she probably had a hand in it.

- Special shoutout to [Beta Testers]()Your feedback has been invaluable!

- Big Credit to [Bostra](https://discord.gg/5ncbwMNq). if you have been around you may have seen him post some free scripts and help people, There was definetly times I dm'd him saying what the fuck am I doing and he helped keep me sane. He also made the cute mushrooms!

- [Jim's Tebex](https://jimathy666.tebex.io/) for putting out open source resources that I was able to break and fix and learn how to code

- [jixeltay](https://jixeltay.tebex.io/category/scripts) for putting out banger after banger. These people help the community learn so much more

- Our partner [1of1 Servers]( https://1of1servers.com/) and their [discord](https://discord.gg/1of1servers) for their amazing server hosting! absolutely top notch.
- Special Thanks To Kamaryn For The Preview
- Thanks to Kamaryn for this [install guide video](https://youtu.be/zvuYnUfrqaA?si=FGJuBO5krZMC14Nd)

- join their [discord](https://discord.gg/KPRmZqFS)  for other videos updates.

# Dependencies

- [ox_lib](https://github.com/overextended/ox_lib/releases/tag/v3.12.0) 

- [qb-target](https://github.com/qbcore-framework/qb-target) **or** [ox_target](https://github.com/overextended/ox_target)
  
- emote script that uses the animations event
    - for example one of these
        - [dpemotes](https://github.com/andristum/dpemotes) -- should use RP instead
        - [rpemotes](https://github.com/alberttheprince/rpemotes-reborn) 
        - [scully_emotemenu](https://github.com/Scullyy/scully_emotemenu)

- [read](https://letters.hookedonphonics.com/us/read-guaranteed-G14.html?vc=HPG1&pc=SHPGBR&tracking_id=102917836048989658da259e8c83e6&url_id=5586&oid=707&vid=1855&cid=4194&hid=14509&utm_source=1855&aff_id2={aff_id2}&utm_campaign=PracticePackHOS&utm_medium=S&utm_content=BrandDollarPacks&gc_id=184380999&h_ad_id=374941048206&src=O&qid=3&msvid=v2)

- GAME BUILD 2944 OR LATER


# Preview

### [Preview link](https://www.youtube.com/watch?v=I_x7_oz_SAU) 

# How to install like a fuckin boss

### STEP 1

- qb-inventory users go to md-drugs/items_install/qb-inventory and add the Items to `qb-core/shared/items.lua` and - Add items from md-drugs/items_install/images to qb-inventory/html/images
- ox_inventory users go to md-drugs/items_install/ox_inventory and add the Items to `ox_inventory/data/items.lua` and - Add items from md-drugs/items_install/images to ox_inventory/web/images

### STEP 2
- delete `qb-drugs` 

### STEP 3
- Inside the config file change **all** the locations for everything.
	- **ps:  All locations have been changed to make a preview video easier and with how big of a script this is, Im not going to config it for every city. THESE LOCATION DO NOT DO WELL FOR A LIVE SERVER SO CHANGE THEM**

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
	

# OPTIONAL STEPS

## Fivemerr
This is NOT a requirement but something I personally use and believe in.


- to integrate with fivemerr make sure you have  ```set fivemerrLogs "API_KEY"```   in your server.cfg
   
- Head to /server/functions.lua turn local logs = true
  
- profit

Why integrate with Fivemerr? Its a great place to store logs as it doesnt rely on discord webhooks and its far easier to search through

As well as a place to offload images and videos from fivem that doesnt rely on discord since discord API will be automatically deleting images and videos after a certain amount of time If you need an invite to their server look below
- [Fivemerr Discord](https://discord.com/invite/fivemerr)
- [Fivemerr Docs](https://docs.fivemerr.com/)

# Radial Menu
- head to `qb-radial/config.lua` and search for the following event
```lua
     event = 'qb-drugs:client:cornerselling',
```
- and change it to this
```lua
     event = 'md-drugs:client:cornerselling',
```


# For Qb-shops users

- Head to `qb-shops/config.lua` **Config.Products** and add the folowing items to OR anywhere else you want them. The Only way in this script to get them is to find the travelling merchant

```lua
	{name = 'bakingsoda',   price = 100,   amount = 5000, info = {}, type = 'item'},
	{name = 'emptyvial',    price = 100,   amount = 5000, info = {}, type = 'item'},
	{name = 'needle',    	price = 100,   amount = 5000, info = {}, type = 'item'},
```

# Tier System
- Turn On Config.TierSystem after you run the sql file

[mlo i use](https://www.gta5-mods.com/maps/mlo-4x-drug-lab-interiors-sp-fivem) heres an option. use it or dont. 
