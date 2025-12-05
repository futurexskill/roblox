# Roblox Game Starter Template

This is a starter template for creating Roblox games with Lua scripts.

## Project Structure

- `/src/server/` - Server-side scripts (ServerScriptService)
- `/src/client/` - Client-side scripts (StarterPlayer/StarterPlayerScripts)
- `/src/shared/` - Shared modules (ReplicatedStorage)
- `/prototype/` - Web-based prototype for testing game concepts

## Roblox Setup Instructions

1. Open Roblox Studio
2. Create a new place or open an existing one
3. Copy the scripts from the `/src/` folders to the appropriate locations:
   - Server scripts → ServerScriptService
   - Client scripts → StarterPlayer → StarterPlayerScripts
   - Shared modules → ReplicatedStorage

## Web Prototype

Open `prototype/index.html` in a web browser to see a visual demo of the game mechanics.

## Features Included

- Player data management
- Leaderboard system
- Basic coin collection system
- Simple GUI/UI framework
- Game manager for handling game state
