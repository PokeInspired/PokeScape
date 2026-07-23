PokeScape 0.3 - Launcher Instructions
=====================================

This folder has two launchers:

Launch PokeScape RuneLite.bat
Launch PokeScape RuneLite - Debug.bat

There is also:

Create Desktop Shortcut.bat

That creates a Desktop shortcut called PokeScape.
The shortcut points to the normal launcher:

Launch PokeScape RuneLite.bat

Using the Desktop shortcut is the preferred way to launch PokeScape after setup.

Use the normal one first:

Launch PokeScape RuneLite.bat

That starts RuneLite directly in developer mode and sideloads PokeScape.

Only use the debug one if PokeScape does not appear or something goes wrong:

PLUGIN UPDATES
==============

Developer mode itself does not stop normal RuneLite plugins from updating.

However, this launcher starts RuneLite directly from the local RuneLite files.
Because of that, it can skip the normal RuneLite launcher update step.

If you want your normal RuneLite plugins and RuneLite cache to stay updated,
open normal RuneLite once every now and then, let it fully load/update, then
close it.

After that, go back to this folder and use:

Launch PokeScape RuneLite.bat

Or 

The shortcut on your desktop



KEEP THESE FILES TOGETHER
=========================

These files must stay in the same folder:

Launch PokeScape RuneLite.bat
Launch PokeScape RuneLite - Debug.bat
Create Desktop Shortcut.bat
pokescape.jar

The folder can be on your Desktop, Downloads, another drive, or a USB stick.
The launcher uses its own folder location, so the drive letter does not matter.

Do not run it from inside a zip file.
Extract the folder first.


Normal folder launch:

1. Close every RuneLite window.

2. Open this folder.

3. Double click: Launch PokeScape RuneLite.bat

4. RuneLite should open.

5. PokeScape should already be loaded. If not, open the plugin list and search: PokeScape

6. If Pokescape loads, close RuneLite and run: Create Desktop Shortcut

If PokeScape does not appear, close RuneLite and run:

Launch PokeScape RuneLite - Debug.bat

Then send Jay the full text from the black command window.


DESKTOP SHORTCUT
================

If you want a Desktop icon, double click:

Create Desktop Shortcut.bat

This is the preferred way to launch PokeScape after the shortcut has been made.

It creates a shortcut called:

Pokescape

The shortcut opens:

Launch PokeScape RuneLite.bat


WHAT THE LAUNCHER DOES
======================

The launcher:

1. Looks next to itself for:

   pokescape.jar

2. Copies that jar into:

   %USERPROFILE%\.runelite\sideloaded-plugins\pokescape.jar

3. Uses RuneLite's own Java from:

   %LOCALAPPDATA%\RuneLite\jre\bin\javaw.exe

   The normal launcher uses javaw.exe so no black command box stays open.
   The debug launcher uses java.exe so errors are visible.

4. Uses RuneLite's local library cache from:

   %USERPROFILE%\.runelite\repository2

5. Starts RuneLite directly with:

   -ea
   --developer-mode




IF IT SAYS RUNE LITE FILES ARE MISSING
======================================

Open normal RuneLite once, let it fully load/update, then close it.

Then run:

Launch PokeScape RuneLite.bat


IF WINDOWS WARNS YOU
====================

Windows may show a warning for script files.

Click:

More info

Then:

Run anyway

Only do this if you trust the person who sent you this folder.
