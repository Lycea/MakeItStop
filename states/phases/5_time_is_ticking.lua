local phase =class_base:extend()


local ctd_left = 75
local ctd_speed = 1
local ctd_timer = glib.timer(1)

local click_count = 0

local btn_id = 0
local btn_pos = nil

local in_dial = false
local done = false

function phase:new()
  self.id = 5
  print("initialised!!")
end

--its the final button , da da da dummmm
function final_button()
  if in_dial == true then
    return
  end

  click_count=click_count+1
  ctd_speed = ctd_speed +1

  if click_count == 1 then
    glib.sceen:start(2)
  elseif click_count == 2 then
    glib.sceen:start(3)

  elseif click_count == 3 then
    glib.sceen:start(4)

  elseif click_count >3 then
    glib.sceen:start(5)
  end

end

function phase:startup()
  glib.sceen:load_file("assets/texts/5.txt")
  glib.sceen:start(1)

  btn_id = glib.ui.AddButton("",
    scr_w/2 - 45,
    scr_h/2,
    90, 40)

  glib.ui.SetSpecialCallback(btn_id, final_button)
  btn_obj = glib.ui.GetObject(btn_id)

  btn_pos = { btn_obj.x, btn_obj.y }
end


local post_sceene = false


function phase:draw()
  if post_sceene then
    glib.console.setSize( scr_w -40, scr_h -40)
    glib.console.setPos(20,20)
  else

    love.graphics.draw(gvar.background_img, 0, 0)
    love.graphics.draw(gvar.button_image, scr_w / 2 - 70, scr_h / 2 + 60)

    love.graphics.draw(gvar.off_button_image, btn_pos[1], btn_pos[2])

    -- love.graphics.setColor(0, 0, 0, 255)
    -- love.graphics.rectangle("fill", 90, 45, 500, 40)
    -- love.graphics.setColor(255, 0, 0, 255)
    -- love.graphics.rectangle("fill", 95, 50, 490, 30)
    -- love.graphics.setColor(255, 255, 255, 255)
    -- full_width = 490
    -- rest_width = math.max(full_width - (full_width*0.01)*ctd_left, 0)
    glib.helper.draw_countdown(ctd_left)


    love.graphics.rectangle("fill", 95, 50, rest_width, 30)
    love.graphics.setColor(255,255,255,255)
  end
  

  glib.sceen:show()
end

local time_warn_1_done = false
local first_time = true

function phase:update()
  glib.sceen:update()
  in_dial = glib.sceen.active

  if ctd_timer:check() and in_dial == false then
    ctd_left = ctd_left - ctd_speed
  end

  if ctd_left <= 20 and time_warn_1_done == false then    
    glib.sceen:start(6)
    in_dial = glib.sceen.active
  
    time_warn_1_done = true
  end

  if ctd_left <= 0 and first_time then
    post_sceene = true
    glib.ui.SetVisibiliti(btn_id, false)
    glib.ui.SetEnabled(btn_id, false)

    glib.sceen:start(7)
    in_dial = glib.sceen.active
    
    first_time = false
  end

  if ctd_left <=0 and not in_dial then
    done = true
  end

  if done then
    return true
  end
end

function phase:shutdown()
    
end





return phase()
