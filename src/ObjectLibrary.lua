-- ObjectLibrary.lua
local ObjectLibrary = {}
ObjectLibrary.__index = ObjectLibrary

function ObjectLibrary:new(x, y, width, height, imagePath)
    local obj = {}
    setmetatable(obj, ObjectLibrary)

    -- Set position and dimensions
    obj.x = x or 0
    obj.y = y or 0
    obj.width = width or 50
    obj.height = height or 50

    -- Set texture
    if imagePath then
        obj.texture = love.graphics.newImage(imagePath)
    else
        obj.texture = nil
    end

    -- Set up collision properties
    obj.isCollidable = true
    obj.isColliding = false

    return obj
end

-- Draw the object (with or without texture)
function ObjectLibrary:draw()
    if self.texture then
        -- Calculate scaling factors based on the desired width and height
        local scaleX = self.width / self.texture:getWidth()
        local scaleY = self.height / self.texture:getHeight()
        
        -- Draw the texture with scaling applied
        love.graphics.draw(self.texture, self.x, self.y, 0, scaleX, scaleY)
    else
        love.graphics.setColor(1, 1, 1) -- white color for the square
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
    love.graphics.setColor(1, 1, 1) -- reset color
end

-- Check for collision with another object
function ObjectLibrary:checkCollision(other)
    return self.x < other.x + other.width and
           other.x < self.x + self.width and
           self.y < other.y + other.height and
           other.y < self.y + self.height
end

-- Handle collision response to prevent movement overlap
function ObjectLibrary:resolveCollision(other)
    if self:checkCollision(other) then
        self.isColliding = true

        -- Calculate overlap on each axis
        local overlapX = math.min(self.x + self.width - other.x, other.x + other.width - self.x)
        local overlapY = math.min(self.y + self.height - other.y, other.y + other.height - self.y)

        -- Resolve the smallest overlap to separate the objects
        if overlapX < overlapY then
            -- Push left or right
            if self.x < other.x then
                self.x = self.x - overlapX
            else
                self.x = self.x + overlapX
            end
        else
            -- Push up or down
            if self.y < other.y then
                self.y = self.y - overlapY
            else
                self.y = self.y + overlapY
            end
        end
    else
        self.isColliding = false
    end
end

return ObjectLibrary
