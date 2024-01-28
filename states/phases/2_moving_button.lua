local phase =class_base:extend()

local btn = nil
local done = false

local move_count = 0

local in_dial = false

local btn_img = nil


local function next_phase()
  if in_dial then
    return
  end

  print("phase check")
  done = true
end


function move_btn()
  if in_dial then
    return
  end

  
  btn_obj = glib.ui.GetObject(btn)

  btn_obj.x = love.math.random(40, scr_w-100)
  btn_obj.y = love.math.random(0, scr_h / 2)
  move_count= move_count+1
  glib.helper.do_when(move_count, 15, function()
    print("change callback")
    next_phase()
    glib.ui.SetSpecialCallback(btn, next_phase)
  end)

  if move_count == 1 then
    glib.sceen:start(2)
  elseif move_count == 2 then
    glib.sceen:start(3)
  elseif move_count == 14 then
    glib.sceen:start(4)
  end
end

function spawn_off_button()
  btn = glib.ui.AddButton("stop it",
    love.math.random(40, scr_w - 100),
    love.math.random(40, scr_h / 2 - 20),
    60, 30)

  glib.ui.SetSpecialCallback(btn, move_btn)
end

local event_stack = {}

function phase:new()
  self.id = 2
  print("initialised move screen!!")

  glib.sceen:load_file("assets/texts/2.txt")
end

local back_image = nil

function phase:startup()
  back_image = love.graphics.newImage("assets/facility.png")
  btn_img = love.graphics.newImage("assets/button_pressed.png")

  glib.sceen:start(1)

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

    love.graphics.draw(back_image, 0, 0)
    love.graphics.draw(btn_img, scr_w / 2 - 70, scr_h / 2 + 60)

    love.graphics.setColor(255, 0, 0, num)
    love.graphics.rectangle("fill", 0, 0, scr_w, scr_h)
  end

  love.graphics.setColor(255, 255, 255)


  glib.sceen:show()
end

function phase:update()

 glib.sceen:update()

 in_dial = glib.sceen.active   
  if done then
    return true
  end
end

function phase:shutdown()
  glib.ui.RemoveComponent(btn)
end





return phase()
