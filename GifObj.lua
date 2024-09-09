--[[
   Defines a GifObj (using sprites)
]]

GifObj = Class{}

function GifObj:init(path, n_frames, n_columns, x, y, width, height, speed)
   self.sprite = love.graphics.newImage(path)
   self.n_frames = n_frames
   self.width = width
   self.height = height
   self.x = x
   self.y = y
   self.speed = speed

   local n_rows = math.floor(n_frames / n_columns)
   self.quads = {}

   local imgWidth, imgHeight = self.sprite:getWidth(), self.sprite:getHeight()
   local spriteWidth = imgWidth / n_columns
   local spriteHeight = imgHeight / n_rows
   for i = 0, n_rows - 1 do
      for j = 0, n_columns - 1 do
         self.quads[#self.quads+1] = love.graphics.newQuad(j * spriteWidth, i * spriteHeight, spriteWidth, spriteHeight, imgWidth, imgHeight)
      end
   end

   self.sx = width / spriteWidth 
   self.sy = height / spriteHeight
   self.timer = 0
end

function GifObj:update(dt)
   self.timer = self.timer + self.speed * dt
end

function GifObj:draw()
   love.graphics.draw(self.sprite, self.quads[(math.floor(self.timer) % self.n_frames) + 1], self.x, self.y, 0, self.sx, self.sy)
end