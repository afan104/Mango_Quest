# Adding a New Region to the Game

## 1. Duplicate the Level Template Scene in the `templates` Folder

If there are already levels in the region, duplicate a level in the region's scene folder. Remember to save the new scene in the `scenes/<region name>` folder.

## 2. Localize

- Open the new scene and rename it to the name of the new region.
- Update all the children by marking them as "Local to Scene". This will allow you to change the properties of the children without affecting the original scene.
- The region comes with a `level_template.gd` script. Create a copy of this script and rename it to the name of the new region. Then, assign the new script to the root node of the scene.

## 3. Design!

A TileMap node is already included in the template. You can use this to design the region. Update the tilesets as needed.

Note: A level boundary is already set up. The region that this level is in uses this boundary to ensure levels are generated right next to each other during transitions. Maintain the size of the boundary and design the level within it. If you need to change the boundary, update `LEVEL_GEN_OFFSET` in the associated region's script. Not doing this can cause camera bugs.
