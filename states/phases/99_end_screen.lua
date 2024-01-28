local phase =class_base:extend()


local big_font = nil
local default_font = nil

function phase:new()
  self.id = 99
  print("initialised end screen!!")
end
local love_icon = nil
function phase:startup()
  big_font = love.graphics.newFont(22)
  default_font = love.graphics.getFont()

  love_icon = love.graphics.newImage("assets/love-app-icon.png")

  
end





function phase:draw()
  offset = 100

  love.graphics.setFont(big_font)
  love.graphics.print("Congratulations you made it to the end!", scr_w / 2 -220, offset)
  love.graphics.print("Hope you enjoyed the ride.", scr_w / 2 -220, 24 + offset)
  love.graphics.print("And maybe had a laugh.", scr_w / 2 - 220, 50 + offset)


  love.graphics.print("Thank you for playing !", scr_w / 2 - 220, 100 + offset)
  love.graphics.print("Made with love(2d)", scr_w / 2 - 220, 150 + offset)
  love.graphics.print("By Lycea", scr_w / 2 - 220, 175 + offset)
  love.graphics.setFont(default_font)

  love.graphics.push()
  love.graphics.draw(love_icon,scr_w/2 + 100, scr_h  - 400,0,0.2,0.2 )
  love.graphics.pop()
end



function phase:update()
end

function phase:shutdown()
    
end





return phase()
