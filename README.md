# ObjectLibrary

`ObjectLibrary` is a simple library for the LÖVE2D game engine that allows users to create objects with physics, collision detection, and optional textures. If no texture is provided, the object defaults to a simple square shape. This library makes it easy to add basic physics interactions, object rendering, and collision handling to LÖVE2D projects.

## Features

- **Easy Object Creation**: Create objects with customizable positions, sizes, and optional textures.
- **Collision Detection**: Automatically detects and handles collisions between objects.
- **Collision Response**: Objects stop overlapping and are separated when colliding.
- **Simple Rendering**: Objects can be drawn with textures or as default squares if no texture is provided.
- **Basic Physics**: Objects can have velocity, acceleration, gravity, and friction, allowing for dynamic movement.
- **Force Application**: Easily apply forces (e.g., gravity or user input) to objects to control their movement.

## Installation

1. Download `ObjectLibrary.lua` and place it in your LÖVE2D project folder.
2. Include it in your main file (`main.lua` or equivalent) with:
   ```lua
   local ObjectLibrary = require("ObjectLibrary")
   ```

## Usage

### Creating Objects

You can create an object by calling `ObjectLibrary:new(x, y, width, height, imagePath)`, where:
- `x` and `y` specify the object's position.
- `width` and `height` specify its dimensions.
- `imagePath` is an optional parameter for adding a texture image.

The object also has the following optional physics properties:
- **`velocityX`, `velocityY`**: Control the object's velocity in the X and Y directions.
- **`accelerationX`, `accelerationY`**: Control the object's acceleration.
- **`gravity`**: Gravity is automatically applied to objects if not overridden.
- **`mass`**: The mass of the object, which influences how forces like gravity affect it.

#### Example

```lua
local ObjectLibrary = require("ObjectLibrary")

local player = ObjectLibrary:new(100, 100, 50, 50, "player.png")
local wall = ObjectLibrary:new(200, 100, 50, 50) -- default to white square
```

### Moving and Updating Objects

In your `love.update(dt)` function, you can move objects, apply forces, and check for collisions:

```lua
function love.update(dt)
    -- Store previous position for collision handling
    local prevX, prevY = player.x, player.y

    -- Apply force (e.g., user input for movement or gravity)
    if love.keyboard.isDown("right") then
        player:applyForce(100, 0)  -- Apply force to move right
    end
    if love.keyboard.isDown("left") then
        player:applyForce(-100, 0) -- Apply force to move left
    end
    if love.keyboard.isDown("up") then
        player:applyForce(0, -100) -- Apply force to move up
    end
    if love.keyboard.isDown("down") then
        player:applyForce(0, 100)  -- Apply force to move down
    end

    -- Update physics (apply gravity, velocity, position)
    player:update(dt)

    -- Resolve collision
    player:resolveCollision(wall)

    -- If collision occurs, restore the previous position
    if player.isColliding then
        player.x, player.y = prevX, prevY
    end
end
```

### Drawing Objects

To render your objects, call `draw()` on each object in your `love.draw()` function:

```lua
function love.draw()
    player:draw()
    wall:draw()
    
    -- Optionally, draw a red border if a collision is detected
    if player.isColliding then
        love.graphics.setColor(1, 0, 0) -- red color for collision
        love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
        love.graphics.setColor(1, 1, 1) -- reset color
    end
end
```

### Physics and Movement

You can take advantage of the built-in physics features:
- **Gravity**: Automatically applied in the `update` method (can be overridden).
- **Velocity**: Update the object's position based on its velocity.
- **Acceleration**: Apply forces like gravity, friction, or user input.

Use `applyForce(fx, fy)` to add external forces to objects. For instance, applying gravity or user-controlled movements.

### Example Physics Application

```lua
function love.update(dt)
    -- Apply gravity force
    player:applyForce(0, player.gravity)

    -- Optionally, apply other forces like user input
    if love.keyboard.isDown("right") then
        player:applyForce(100, 0)
    end

    -- Update physics (gravity, velocity, position)
    player:update(dt)
end
```

## Example Project Structure

```
your_project/
├── main.lua
├── ObjectLibrary.lua
└── assets/
    └── player.png
```

In this example, `main.lua` initializes the library and uses it to create objects. The `assets/` folder holds any textures (like `player.png`) used by objects.

## License

This library is free to use under the MIT License. See [LICENSE](LICENSE) for more details.

---

## Contributing

Feel free to open issues or submit pull requests with improvements or additional features. All contributions are welcome!

---

## Author

Developed by [Virus](https://github.com/Virus01Official).
