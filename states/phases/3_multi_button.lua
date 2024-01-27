local phase =class_base:extend()


local done = nil
local btn_count = 20
local function count_down_callback(obj_id)
  print("triggered cb")
  btn_count=btn_count -1
  glib.ui.SetVisibiliti(obj_id, false)
  glib.ui.SetEnabled(obj_id, false)
  if btn_count == -1 then
    done = true
  end
end

local function spawn_rnd_button()
  local btn = glib.ui.AddButton("stop it",
                                love.math.random(40, scr_w- 40),
                                love.math.random(40, scr_h / 2 - 30),
                                 60, 30)
  glib.ui.SetSpecialCallback(btn,count_down_callback)
end

function phase:new()
    self.id = 3
    print("initialised multi button sceene!!")
end



function phase:startup()
for i=0, btn_count do
  spawn_rnd_button()
end
print("spawning done")
end





function phase:draw()
  
end



function phase:update()
  print("updating")
  if done then
    return true
  end

end

function phase:shutdown()
    
end





return phase()
