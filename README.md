# PokeScape Sideloader

Welcome to **PokeScape**, a RuneLite side game about collecting animated fantasy cards while you play Old School RuneScape.

Open packs, build your album, trade duplicates, earn shards, chase shiny cards, reveal wilderness cards, follow treasure maps, and slowly turn normal OSRS activity into a collectible card adventure.

## What This Is

PokeScape is a **sideloaded RuneLite plugin**. It runs locally through RuneLite developer mode and loads from the `pokescape.jar` included in this folder.

It is not an official RuneLite Plugin Hub release.

## Why It Is Sideloaded

PokeScape is being released this way because:

- The plugin is large for a normal RuneLite plugin, mostly because it includes lots of card art, sounds, animations, and UI assets.
- The theme is inspired by monster-collecting card games, which RuneLite may not accept on Plugin Hub.
- Sideloading lets friends and testers play early builds without waiting for Plugin Hub review.
- It keeps this as a private/community test build while the game is still changing quickly.

## What You Get In This Folder

- `pokescape.jar` - the plugin file RuneLite loads.
- `Launch PokeScape RuneLite.bat` - the normal launcher.
- `Launch PokeScape RuneLite - Debug.bat` - debug launcher if something goes wrong.
- `Create Desktop Shortcut.bat` - creates a desktop shortcut called PokeScape.
- `Reset PokeScape Save.bat` - clears your local PokeScape progress if needed.
- `README - INSTALLATION.txt` - simple install and launch instructions.
- `PokeScape Wiki.html` - player guide with game systems, rewards, drops, packs, wheel, maps, and more.
- `PokeScape-PS.ico` - shortcut icon.

## Quick Start

1. Download this folder.
2. Do not run it from inside a zip file. Extract it first. **It can be placed anywhere you like.**
3. Close every RuneLite window.
4. Run RuneLite **(NOT through Jagex Launcher)** at least once. Then close it.
5. Open windows search bar and look for **RuneLite (Configure)**
6. In **Client Arguments** Type: `--insecure-write-credentials` and click save.
7. Run Runelite through the Jagex Launcher using your profile once. Then close it.
 
**!!! THIS WILL CREATE A** `credentials.properties` **INSIDE YOUR** `.runelite` **FOLDER. DO NOT SHARE THIS WITH ANYONE !!!**

8. Double click `Launch PokeScape RuneLite.bat`, if it can not find your RuneLite folder it will ask you to choose it. 
9. RuneLite should open with PokeScape loaded.
10. Search for `PokeScape` in the plugin list and enable it if needed.
11. After it works, run `Create Desktop Shortcut.bat` to make a desktop icon. **This is the preferred way to launch PokeScape**

The launcher automatically creates RuneLite's sideloaded plugin folder and copies `pokescape.jar` into it.

## Jagex Launcher Notes

If RuneLite files are missing or out of date, open normal RuneLite once, let it fully load and update, close it, then use the PokeScape launcher again.

## Does Developer Mode Stop Other Plugins Updating?

Developer mode itself does not stop normal RuneLite plugins from updating.

This sideloader launches RuneLite directly, which can skip the normal RuneLite launcher update step. To keep normal RuneLite and normal plugins fresh, open normal RuneLite once every now and then, let it update, then go back to launching with PokeScape.

## Game Features

PokeScape currently includes:

- Main card album
- Shiney card album
- Wilderness card reveal system
- Silver, Mithril, Rune, and Shiney packs
- Animated pack opening and card reveals
- Shards and Shard Dust
- Duplicate card trading
- PokeScape Wheel
- Treasure maps
- Rune and essence drops
- Clue casket rewards
- Evolution stones and card evolution
- Sounds and full-screen reward animations

Open `PokeScape Wiki.html` for the full player guide.

## Important

PokeScape rewards are plugin-only. They do not create, change, or trade real OSRS items.

This is a work-in-progress test build. Balance, drop rates, images, rewards, and features may change between versions.

## Troubleshooting

If you want a fresh start:

1. Close RuneLite.
2. Run `Reset PokeScape Save.bat`.
3. Launch PokeScape again.

