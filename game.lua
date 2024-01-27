require("key_handle")
require("renderer.renderer")

require("states.game_states")
sample_state=require("states.state_sample")


local game ={} 


--------------------------- 
--preinit functions? 
--------------------------- 
 
 
local base={} 
------------------------------------------------------------ 
--Base data fields 
------------------------------------------------------------ 
 

constants = nil


------------------------ 
-- dynamic data 



--game state
game_state = GameStates.MAIN_MENUE
previous_game_state = game_state



--others
key_timer = 0--timer between movement

mouse_coords={0,0}


exit_timer =0
selector_timer = 0
target_timer   = 0

----------------------------------------------------------- 
-- special data fields for debugging / testing only 
----------------------------------------------------------- 

--loading a game
function game.load() 
  game_state = GameStates.PLAYING
  game.new()
end 
 
 
 --new game
function game.new()
   sample_state:startup()
end

function game.play(dt) 
  sample_state:update()
end 
 
--main loop
function game.update(dt) 
  
  --handle game stuff
  game.play(dt)
  glib.ui.update()
end

 
function game.draw() 
    sample_state:draw()
    glib.ui.draw()
end 


function game.keyHandle(key,s,r,pressed_) 
  if pressed_ == true then
    key_list[key] = true
    last_key=key
  else
    key_list[key] = nil
  end
end 


function game.MouseHandle(x,y,btn) 

end 
 
function game.MouseMoved(mx,my) 
  mouse_coords={mx,my}
end 
 
 

return game
