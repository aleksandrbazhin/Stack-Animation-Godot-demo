# Stacked sprite animation with "StackAn"

## The concept of the stacked sprite animation

There are several technique which can present 2D images as having some 3D depth without the actual 3D model. One is creating normal maps and using 2D lighting. Another is stacking several layers of 2D sprites and sliding them to create some sort of parallax effect. To simplify the latter is our aim here.

## The solution

We expect that this can be greatly simplified by having a separate step in your project pipeline to setup the stack and its animation. Here it is - StackAn. 

You load your sprites which are to be stacked, then set up the relative height (z) for each one in the stack, but also can setup xy-offset and a pivot point. Then you export your project as a JSON file with a packed texture.

The main time saver for users can be not the utitity to stack the existing sprites, but to generate several sprites from a single one to create that parallax effect. The most obvious approach is to use a vector mask to cut the sprite in parts and fill the holes on the lower levels (copying of higher level is a poor option since it creates obvious artefacts).

The original idea was to create those vector masks automaticly, which can be possible if we new the 3D geometry of the object which the sprite represents. Then we would need a heightmap editor built in in our application. The alternative approach to create a self-sufficient app is to embed a vector mask editor, which we plan to go for.

Several runtimes for common game engines are planned.

### External variables

In games animations are often affected by user input or by another game state. So there should be several variables which can be modified by a game developer. 

Several variables are built-in, these are 
- pitch 
- roll
- yaw (rotation) is separate for each slice 

Later we plan to add the ability to setupu your own external variables to allow for more complex animations.

### The exchange format
The animations are supposed to be stored as a .json documents accompanied with textures.

#### Export JSON Structure
The overall document srtucture on an example of a ship 

```json
{
    "name": "Ship",
    "texture path": "Ship.png",
    "stack": [
        Sprite definition 1,
        Sprite definition 2,
        Sprite definition 3,
        ...
    ]
}

```

Where Sprites in the stack can be either static or animated. 

Static sprite:

```json
{
    "type": "static",
    "sprite-size": {
        "x": 100.0,
        "y": 200.0
    },
    "sprite-offset": {
        "x": 0.0,
        "y": 0.0
    },
    "z-level": -1.0,
    "xy-origin": {
        "x": 0.0,
        "y": 0.0
    },
    "xy-pivot": {
        "x": 0.0,
        "y": 0.0
    },
    "rotation": 0.0,
    "scale": {
        "x": 1.0,
        "y": 1.0
    }
}
```


- **sprite_size** - the size to cut off from the texture atlas 
- **sprite_offset** - where to cut it from
- **z-level** - the level of the sprite whic will be used to oreder the sprites and calulate it's movement when the whole object moves
- **xy-origin** - the offset of the sprite inside the object
- **rotation** - the angle at which the the s[rite is rotated related to the object
- **scale** - the scale of that sprite


Animated sprite:

```json       
{
    "type": "animated",
    "sprite-size": {
        "x": 0.0,
        "y": 0.0
    },
    "animation-fps": 8,
    "animation-frames": [
        {
            "frame-offset": {
                "x": 0.0,
                "y": 0.0
            }
        },
        {
            "frame-offset": {
                "x": 0.0,
                "y": 0.0
            }
        },
        {
            "frame-offset": {
                "x": 0.0,
                "y": 0.0
            }
        },
        {
            "frame-offset": {
                "x": 0.0,
                "y": 0.0
            }
        },
        {
            "frame-offset": {
                "x": 0.0,
                "y": 0.0
            }
        }
    ],
    "z-level": 5.0,
    "xy-origin": {
        "x": 0.0,
        "y": 0.0
    },
    "xy-pivot": {
        "x": 0.0,
        "y": 0.0
    },
    "rotation": 0.0,
    "scale": {
        "x": 1.0,
        "y": 1.0
    }
}
```
Frames in the animated sprites are changed at a constant FPS and are cut of the texture atlas at **frame-offset** coordinates.

### The runtime
There can be two ways to visualize the stack. 
- 2D runtime: sprites slide against each other, creating a parallax effect.
- 3D runtime: sprites are placed above each other in a 3D environment, rotating with camera.

#### Godot engine

The runtie for a Godot engine with an example animation is provided.

### StackAn generator - Qt5 program

Some kind of magic that helps

#### Internal project formats

One folder - one project paradigm. The folder has to have a top level .stackan_project file, which is a json with the following:

```json
{
    "name": "project name",
    "sprites": [
        Sprite definition 1,
        Sprite definition 2,
        Sprite definition 3,
        ...
    ],
    "export_path": "path to last export"
}
```

Where sprite definitions are 
```json
{
    "type": "static",
    "texture-path": "path to texture",
    "sprite-slices": [
        {
            "z-level": 0.0,
            "mask": []
        },
        {
            "z-level": 1.0,
            "mask": [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]]
        }
    ],
    "sprite-size": {
        "x": 100.0,
        "y": 200.0
    },
    "sprite-offset": {
        "x": 0.0,
        "y": 0.0
    },
    "z-level": -1.0,
    "xy-origin": {
        "x": 0.0,
        "y": 0.0
    },
    "xy-pivot": {
        "x": 0.0,
        "y": 0.0
    },
    "rotation": 0.0,
    "scale": {
        "x": 1.0,
        "y": 1.0
    }
}
```
- **sprite-slices** is an array of vector masks which cut the incoming texture to several sprites on different **z-level**s **z-level** here overrides the **z-level** of the sprite


## What's next?
- custom internal and external variables
- trajectories for internal variables
- bones and IK
- texture deformation in the runtime (like in Spine)
