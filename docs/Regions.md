# Adding a New Region to the Game

## 1. Duplicate the Region Template Scene in the `templates` Folder

Remember to save the new scene in the `scenes/<region name>` folder. Create a new folder if it doesn't exist yet.

## 2. Localize

- Open the new scene and rename it to the name of the new region.
- Update all the children by marking them as "Local to Scene". This will allow you to change the properties of the children without affecting the original scene.
- The region comes with a `region_template.gd` script. Create a copy of this script and rename it to the name of the new region. Then, assign the new script to the root node of the scene.

## 3. Design!

Generally, you don't need to "design" a region; you need to design the levels that will be in the region. For this, update the script attached to the region created in the previous step by copying `region_template.gd`.

The main part to pay attention to is:

```gdscript
@onready var levels = [
    "res://scenes/regions/jungle/level_1.tscn",
    "res://scenes/regions/jungle/level_2.tscn",
    "res://scenes/regions/jungle/level_3.tscn",
    "res://scenes/regions/jungle/level_4.tscn",
    ...
]

# Directions for level transitions
@onready var level_transitions = [
    Vector2.ZERO,
    Vector2.RIGHT,
    Vector2.UP,
    Vector2.DOWN,
    ...
]
```

In this script, update the `levels` array with paths to the levels that will be in the region. Also, update the `level_transitions` array with the fade transition animations used when transitioning to each level. Ensure levels and transitions are correctly matched.

For example, for level 2, `Vector2.RIGHT` indicates a left-to-right transition when the level loads.

For the first region, use `Vector2.ZERO` as the transition, as it doesn't need to "transition" from anywhere.

To design the actual levels, follow the steps in the [Level Design](./Levels.md) guide.

Note: Region levels have a fixed boundary already set up. The region uses this boundary to ensure levels generate next to each other during transitions. Maintain the boundary size; if you change it, update `LEVEL_GEN_OFFSET` in the region's script to avoid camera issues.
