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
   OBS: to use these options, you must give values to window_width and/or window_height
]]

Class = require "class"
local colors = require "colors"

TextObj = Class{}

-- Creates a Text Object
-- @param content (string): content of the text
-- @param font_path (string): filepath of the font file
-- @param font_size (number): size of font
-- @param text_color (colors, see colors.lua): color of the text; if nil, sets to white
-- @param x (number): coordinate of text; if options[x] == "center", can be nil
-- @param y (number): coordinate of text; if options[y] == "center", can be nil
-- @param options (table): options of locations of text; see top comment; if nil, uses top-left aligment
-- @param window_width (number): width of screen; if options[x] == nil, can be nil
-- @param window_height (number): height of screen; if options[y] == nil, can be nil
-- @return none
function TextObj:init(content, font_path, font_size, text_color, x, y, options, window_width, window_height)
   self.font_path = font_path  -- must remember so we can change font size
   local font = love.graphics.newFont(font_path, font_size)
   self.text = love.graphics.newText(font, content)
   if text_color then
      self.colors = text_color
   else 
      self.colors = colors.white
   end

   self.margin_x = x
   self.margin_y = y
   self.options = options
   self.window_width = window_width
   self.window_height = window_height
   self:set_location()
end

-- Auxiliary method to set the correct location of the text, based on its options
-- @return none
function TextObj:set_location()
   if self.options == nil then
      self.x = self.margin_x
      self.y = self.margin_y
      return
   end

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
      self.x = self.margin_x
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

-- Updates the text (content and/or size and/or color), as well as correct its place on the screen if needed
-- @param content (string): new content of the object; if nil, doesnt change it
-- @param font_size (number): new font size of the object; if nil, doesnt change it
-- @param color (colors, see colors.lua): new color of the object; if nil, doesnt change it
-- @return none
function TextObj:update_text(content, font_size, color)
   if content then
      self.text:set(content)
   end
   if font_size then
      local new_font = love.graphics.newFont(self.font_path, font_size)
      self.text:setFont(new_font)
   end
   if color then
      self.color = color
   end
   self:set_location()
end


-- Updates the location of the object, and can change options and window dimensions if needed
-- @param x (number): coordinate of text; if nil, doesnt change it
-- @param y (number): coordinate of text; if nil, doesnt change it
-- @param options (table): options of locations of text; see top comment; if nil, uses previously defined options
-- @param window_width (number): width of screen; if nil, uses previously defined window_width
-- @param window_height (number): height of screen; if nil, uses previously defined window_height
-- @return none
function TextObj:update_location(x, y, options, window_width, window_height)
   self.margin_x = x or self.margin_x
   self.margin_y = y or self.margin_y
   self.options = options or self.options
   self.window_width = window_width or self.window_width
   self.window_height = window_height or self.window_height
   self:set_location()
end

-- Draws the text onto the screen
function TextObj:draw()
   colors:setColor(self.colors)
   love.graphics.draw(self.text, self.x, self.y)
end
