# GMTK Game Jam 2024 entry

TBD: Description of the game.

## How to play

TBD: How to play the game.

## Authors

- [NAME](https://social-link-here)

## Tech stack

- Godot Engine 4.2.2
- GDScript

## License

TBD: Discuss the licensing of the game.

## Folder structure

- `assets/`: Contains all the assets used in the game categorized by type:
  - `audio/`: Contains all the audio files used in the game
  - `models/`: Contains all the 3D models used in the game (if any)
  - `sprites/`: Contains all the 2D and animated sprites used in the game
  - `textures/`: Contains all the textures (not sprites) used in the game that are not specific to a single model
- `resources/`: Contains all the serialized resources used in the game categorized by type. These could be tilemaps, materials, particle effects, etc.
- `scenes/`: Contains all the scenes used in the game categorized by type:
  - `autoloads/`: Contains all the global scenes (autoloads)
  - `characters/`: Contains all the character scenes
  - `levels/`: Contains all the level scenes
  - `objects/`: Contains all the interactive objects used in the game (doors, switches, pickups, etc.)
  - `props/`: Contains all the non-interactive props used in the game (walls, foliage, furniture, etc.)
  - `ui/`: Contains all the UI scenes
  - `main.tscn`: The main scene of the game
- `scripts/`: Contains all the scripts used in the game categorized by features