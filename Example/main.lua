-- main.lua
local ObjectLibrary = require("ObjectLibrary")

local player
local wall
local speed = 100

function love.load()
    -- Create two objects, one with an image and one without
    player = ObjectLibrary:new(100, 100, 50, 50, "player.png") -- assumes you have a player.png
    wall = ObjectLibrary:new(200, 100, 100, 100) -- no image, defaults to a white square
end

function love.update(dt)
    local prevX, prevY = player.x, player.y

    -- Move player with arrow keys
    if love.keyboard.isDown("right") then player.x = player.x + speed * dt end
    if love.keyboard.isDown("left") then player.x = player.x - speed * dt end
    if love.keyboard.isDown("up") then player.y = player.y - speed * dt end
    if love.keyboard.isDown("down") then player.y = player.y + speed * dt end

    -- Check for and resolve collision
    player:resolveCollision(wall)

    -- Check if player was pushed back (indicating collision)
    if player.isColliding then
        -- Collision detected
        player.x, player.y = prevX, prevY -- restore previous position to prevent overlap
    end
end

function love.draw()
    -- Draw objects
    player:draw()
    wall:draw()

    -- Draw a red border around the player if colliding with wall
    if player.isColliding then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
        love.graphics.setColor(1, 1, 1) -- reset color
    end
end
