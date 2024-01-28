local phase =class_base:extend()


local done = nil
local btn_count = 30
local btn_pos_list = {}

local clicked_this_cycle = false
local in_dial = false

local function count_down_callback(obj_id)
  if in_dial or clicked_this_cycle then
    return
 end

  clicked_this_cycle = true
  btn_count=btn_count -1
  glib.ui.SetVisibiliti(obj_id, false)
  glib.ui.SetEnabled(obj_id, false)

  btn_pos_list[obj_id].draw = false
  print("btns left:", btn_count )
  print("ln:",#btn_pos_list)

  if btn_count == 25 then
    print("trigger s2")
    glib.sceen:start(2)
  elseif btn_count == 15 then
    print("trigger s3")
    glib.sceen:start(3)
  elseif btn_count == 3 then
    print("trigger s4")
    glib.sceen:start(4)
  end

  if btn_count == 2 then
    done = true
  end
end
local btn_timer = glib.timer(0.1)
local spawning_done = false

local function spawn_rnd_button()
  local btn = glib.ui.AddButton("",
    love.math.random(82, scr_w - 180),
    love.math.random(32, scr_h - 240),
    90, 40)

  glib.ui.SetSpecialCallback(btn, count_down_callback)

  local btn_obj = glib.ui.GetObject(btn)

  btn_pos_list[btn]={
                 id= btn,
                 x =btn_obj.x,
                 y =btn_obj.y,
                 draw = true
  }
end

local function slow_spawn_btn()
  if btn_timer:check() then
    spawn_rnd_button()
  end
end

function phase:new()
  self.id = 2
  print("initialised multi button sceene!!")

  glib.sceen:load_file("assets/texts/3.txt")
end



function phase:startup()
  glib.sceen:start(1)
end

function phase:draw()
  love.graphics.draw(gvar.background_img, 0, 0)
  love.graphics.draw(gvar.button_image, scr_w / 2 - 70, scr_h / 2 + 60)

  for _, btn_info in pairs(btn_pos_list) do
    if btn_info.draw == true then
      love.graphics.draw(gvar.off_button_image,btn_info.x,btn_info.y)
    end
  end

  glib.sceen:show()
end


function phase:update()
  clicked_this_cycle = false

  glib.sceen:update()
  in_dial = glib.sceen.active

  --button spawning
  if not spawning_done then
    slow_spawn_btn()
    if #btn_pos_list == btn_count then
      spawning_done = true 
    end
  end

  if done then
    return true
  end

end

function phase:shutdown()
    -- for _, btn in pairs(btn_pos_list) do
    --   glib.ui.RemoveComponent(btn.id)
   -- end
end





return phase()
