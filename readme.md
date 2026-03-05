# 🌿 MD-Drugs – Advanced Drug System for FiveM

> ✨ A fully customizable, immersive, and performance-optimized drug system built for serious FiveM roleplay servers.

<div align="center">
   <a href="https://discord.gg/sAMzrB4DDx" >
        <img style="width:200px;", src="https://i.imgur.com/t65G9Z0.png"></img>
    </a>
    
**[Join Mustache Scripts Discord](https://discord.gg/sAMzrB4DDx)**
</div>

---
## 📦 Dependencies

> ⚠️ **Important:** Ensure all dependencies are installed, started **before** `md-drugs`, and kept up to date.

| Dependency | Requirement | Link |
|-----------|-------------|------|
| `Community_bridge` | Required | [GitHub](https://github.com/TheOrderFivem/community_bridge) |
| `Read` | Required | [Documentation](https://letters.hookedonphonics.com/us/read-guaranteed-G14.html) |
| **Game Build** | **2944 or later** | - |

---
## 🙏 Credits

A huge thank you to everyone who made this possible:

| Contributor | Contribution | Link |
|------------|--------------|------|
| **Samuel's Development** | Christmas script global states & prop spawning | [Visit](https://fivem.samueldev.shop/) |
| **STACHY225** | Meth network animations | [Visit](https://babiczind.tebex.io/category/2103836) |
| **Bostra** | Free scripts, sanity checks & mushrooms | [Discord](https://discord.gg/5ncbwMNq) |
| **Feisty** | Stunning visuals & effects | - |
| **Athena** | Balloon props | [Discord](https://discord.gg/mam8Nmg49d) |
| **Kamaryn** | Installation guide video | [Watch](https://youtu.be/zvuYnUfrqaA?si=FGJuBO5krZMC14Nd) |
| **1of1 Servers** | Hosting & support | [Website](https://1of1servers.com/) \| [Discord](https://discord.gg/1of1servers) |
| **Beta Testers** | Invaluable feedback & testing | - |

---

## 🎬 Preview

<div align="center">

[![Watch Full Preview](https://img.youtube.com/vi/I_x7_oz_SAU/maxresdefault.jpg)](https://www.youtube.com/watch?v=I_x7_oz_SAU)

**[📺 Watch Full Preview Video](https://www.youtube.com/watch?v=I_x7_oz_SAU)**

</div>

---



## 🛠️ Installation

### Step 1: Inventory Integration

#### 📦 For QBCore (`qb-inventory`)

1. **Copy Items:**
   - Copy items from `md-drugs/items_install/qb-inventory` into `qb-core/shared/items.lua`

2. **Add Images:**
   - Add item images from `md-drugs/items_install/images` to `qb-inventory/html/images`

#### 📦 For OX_Inventory

1. **Copy Items:**
   - Copy items from `md-drugs/items_install/ox_inventory` into `ox_inventory/data/items.lua`

2. **Add Images:**
   - Add item images to `ox_inventory/web/images`

---

### Step 2: Configure Drug Locations & Recipes

All drug data is now organized in: `shared/DrugData/{drugname}.lua`

> ✏️ **Tip:** Modify these files to customize:
> - Spawn points
> - Yields
> - Processing times
> - And more!

*Note: Some data is also located in the server files.*

---

### Step 3: QBCore Users Only! ⚠️

If you're using QBCore, check `qb-smallresources/config.lua`:

1. Look for this code block:
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
### STEP 4
- Run SQL
    - if you dont know how, click this image below
        - [![YouTube Video](https://img.youtube.com/vi/8QpFOluK_xo/hqdefault.jpg)](https://www.youtube.com/watch?v=8QpFOluK_xo)

### STEP 5 
- If you want whippits, take the folder `ate_balloon` and place that folder into the standalone folder like it was another script :)
