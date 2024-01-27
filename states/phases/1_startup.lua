local phase =class_base:extend()
local big_font = nil
local default_font = nil

local done = false
local btns ={
  
}

local function start_click()
    print("clicked start")
    done = true
    for btn in pairs(btns) do
      glib.ui.SetEnabled(btn,false)
    end
end


local function hover()
  hover = true
end

function phase:new()
  self.id = 1
  print("initialised start screen!!")
end

function phase:startup()
  big_font = love.graphics.newFont(22)
  default_font = love.graphics.getFont()

  top_btn = glib.ui.AddButton("top", scr_w / 2 - 40, scr_h / 2 - 20, 80, 40)
  bot_btn = glib.ui.AddButton("bot", scr_w / 2 - 70, scr_h / 2 + 20, 160, 20)

  table.insert(btns, top_btn)
  table.insert(btns, bot_btn)

  for id in pairs(btns) do
    glib.ui.SetSpecialCallback(id, start_click)
    glib.ui.SetSpecialCallback(id, hover ,"onHover")
  end
end


local num = 0
local num_change = 0.3
function phase:draw()
  num = num + num_change
  if num >= 255 then
    num_change = -0.3
  elseif num < 0 then
    num_change = 0.3
  end
  love.graphics.setColor(255, 0, 0, num)
  love.graphics.setFont(big_font)
  love.graphics.print("Push button", scr_w / 2 , 0)
  love.graphics.print("   to start", scr_w / 2, 30)
  love.graphics.setFont(default_font)

end



function phase:update()
  if done then
    return true
  end

end

function phase:shutdown()
    
end





return phase()