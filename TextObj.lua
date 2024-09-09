--[[
   Defines a Text Object, which is a drawable string
   Proporties of this object:
      - Drawable: can be drawn
      - Mutable: both its content and style can be changed
      - Movable: you can change its place on the screen

   OBS: x,y by default represent the coordinate of the top-left pixel
   options values:
      x:
         - center: aligns text to center
         - right = uses x as a right-margin, instead of left-margin;
      y: 
         - center: centers the text in the y-axis;
         - bottom: uses y as a bottom-margin, instead of a top-margin;
   to use any of this values, use {x = <string>, y = <string>} 
]]

TextObj = Class{}
local colors = require "colors"

-- Creates a Text Object
-- @param content (string): content of the text
-- @param font_path (string): filepath of the font file
-- @param font_size (number): size of font
-- @param text_color (colors, see colors.lua): color of the text; if nil, sets to white
-- @param window_width (number): width of screen
-- @param window_height (number): height of screen
-- @param x (number): coordinate of text; if options[x] == "center", can be nil
-- @param y (number): coordinate of text; if options[y] == "center", can be nil
-- @param options (table): options of locations of text; see top comment
-- @return none
function TextObj:init(content, font_path, font_size, text_color, window_width, window_height, x, y, options)
   local font = love.graphics.newFont(font_path, font_size)
   self.text = love.graphics.newText(font, content)
   if text_color then
      self.colors = text_color
   else 
      self.colors = colors.white
   end

   self.margin_x = x
   self.margin_y = y
   self.window_width = window_width
   self.window_height = window_height
   self.options = options
   self:set_location(x, y)
end

-- Auxiliary method to set the correct location of the text, based on its options
-- @return none
function TextObj:set_location()
   if self.options == nil then
      self.x = self.margin_x
      self.y = self.margin_y
      return

   local w = self.text:getWidth()
   local h = self.text:getHeight()

   local op
   if self.options.x then
      op = self.options.x
      if op == "center" then
         self.x = (self.window_width - w) / 2
      elseif op == "right" then
         self.x = (self.window_width - w - self.margin_x) 
      end
   else
      self.x = margin_x
   end
   if self.options.y then
      op = self.options.y
      if op == "center" then
         self.y = (self.window_height - h) / 2
      elseif op == "bottom" then
         self.y = (self.window_height - h - self.margin_y) 
      end
   else
      self.y = self.margin_y
   end
end

-- Updates the content, as well as correct its place on the screen if needed
-- @param new_content (string): new content of the object
-- @return none
function TextObj:update_content(new_content)
   self.text:set(new_content)
   self:set_location()
end

-- draws text
function TextObj:draw()
   colors:setColor(self.colors)
   love.graphics.draw(self.text, self.x, self.y)
end
