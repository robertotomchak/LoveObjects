--[[
    Defines the image object
    an image is created based on a path file, resized in the form of a rectangle
    since Image is already the name of an object in LOVE2D, we will call it ImageObj
]]

ImageObj = Class{}
local colors = require("colors")

-- initiates an image object
-- path: path to image file
-- (x, y): coordinates of top-left corner of image
-- (width, height): dimensions of image
function ImageObj:init(path, x, y, width, height)
    self.image = love.graphics.newImage(path)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.sx = width / self.image:getWidth()
    self.sy = height / self.image:getHeight()
end

-- draws image
function ImageObj:draw()
    colors:setColor(colors.white)
    love.graphics.draw(self.image, self.x, self.y, 0, self.sx, self.sy)
end

-- resizes image to required value
function ImageObj:resize(new_width, new_height)
    self.width = new_width
    self.height = new_height
    
    self.sx = new_width / self.image:getWidth()
    self.sy = new_height / self.image:getHeight()
end

-- reallocates image to new coordinates
function ImageObj:reallocate(x, y)
    self.x, self.y = x, y
end