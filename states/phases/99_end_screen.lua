local phase =class_base:extend()


local big_font = nil
local default_font = nil

function phase:new()
  self.id = 99
  print("initialised end screen!!")
end

function phase:startup()
  big_font = love.graphics.newFont(22)
  default_font = love.graphics.getFont()
  
end





function phase:draw()
  love.graphics.setFont(big_font)
  love.graphics.print("GG u won!", scr_w / 2, 0)
  love.graphics.setFont(default_font)
end



function phase:update()
end

function phase:shutdown()
    
end





return phase()
