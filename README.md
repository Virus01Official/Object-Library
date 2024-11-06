---

# ObjectLibrary

`ObjectLibrary` is a simple library for the LÖVE2D game engine that allows users to create objects with collision detection and optional textures. If a texture is not provided, the object defaults to a simple square shape. This library can help developers quickly add basic object collision and rendering to their LÖVE2D projects.

## Features

- **Easy Object Creation**: Define objects with positions, sizes, and optional textures.
- **Collision Detection**: Automatically detects and handles collisions between objects.
- **Collision Response**: Objects cannot overlap; they stop moving into each other when colliding.
- **Simple Rendering**: Renders objects with textures, or as a default square if no texture is specified.

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

#### Example

```lua
local ObjectLibrary = require("ObjectLibrary")

local player = ObjectLibrary:new(100, 100, 50, 50, "player.png")
local wall = ObjectLibrary:new(200, 100, 50, 50) -- default to white square
```

### Moving and Updating Objects

In your `love.update(dt)` function, you can move objects and check for collisions:

```lua
function love.update(dt)
    -- Store previous position
    local prevX, prevY = player.x, player.y

    -- Move player using arrow keys
    if love.keyboard.isDown("right") then player.x = player.x + 100 * dt end
    if love.keyboard.isDown("left") then player.x = player.x - 100 * dt end
    if love.keyboard.isDown("up") then player.y = player.y - 100 * dt end
    if love.keyboard.isDown("down") then player.y = player.y + 100 * dt end

    -- Resolve collision
    player:resolveCollision(wall)

    -- If collision occurs, restore previous position
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
    
    -- Draw a red border if collision is detected
    if player.isColliding then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
        love.graphics.setColor(1, 1, 1) -- reset color
    end
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
