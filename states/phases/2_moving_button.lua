local phase =class_base:extend()

local btn = nil
local done = false

local move_count = 0

local function next_phase()
  print("phase check")
  done = true
end

function move_btn()
  btn_obj = glib.ui.GetObject(btn)
  btn_obj.x = love.math.random(0, scr_w)
  btn_obj.y = love.math.random(0, scr_h / 2)
  move_count= move_count+1

  glib.helper.do_when(move_count, 3, function( )
                        print("change callback")
                        next_phase()
                        glib.ui.SetSpecialCallback(btn,next_phase)                          
                        end )
end

function spawn_off_button()
  btn = glib.ui.AddButton("stop it",
                          love.math.random(40,scr_w -40),
                          love.math.random(40,scr_h /2-20),
                           60, 30)
  glib.ui.SetSpecialCallback(btn, move_btn)
end


function phase:new()
  self.id = 2
  print("initialised move screen!!")
end

function phase:startup()
  spawn_off_button()
end

local num = 0
local num_change = 0.2
local flash_active = true

function phase:draw()
  if flash_active then
    num = num + num_change
    if num >= 150 then
      num_change = -0.1
    elseif num < 0 then
      num_change = 0.2
    end
    love.graphics.setColor(255, 0, 0, num)
    love.graphics.rectangle("fill", 0, 0, scr_w, scr_h)
  end
end

function phase:update()
  if btn then
  end

  if done then
    return true
  end
end

function phase:shutdown()
  glib.ui.RemoveComponent(btn)
end





return phase()
