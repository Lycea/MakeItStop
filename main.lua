gr = love.graphics


debuger = {
  on = function() if debuger.no_print then return end print("Not able to turn debuger on , start in debug mode")end,
  off = function() if debuger.no_print then return end print("Not able to turn debuger off , start in debug mode")end,
  start = function() if debuger.no_print then return end print("Not able to start debuging , start in debug mode")end,
  no_print = true
}


class_base= require("helper.classic")

g = require("globals")

gvar = g.vars
glib = g.libs

console =require("helper.console")
timer =require("helper.timer")

game =require("game")

gvar.button_config = {}


local maj,min,rev=love.getVersion()
if maj >= 11 then
    require("helper.cindy").applyPatch()
end


-- function click_start()
--   print("omg you clicked it D:")
-- end

function love.load(args)
  
  for idx, arg in pairs(args) do
      if arg == "-debug" then
        debuger = require("mobdebug")
        debuger.start()
        debuger.off()
        break
      end
  end
  
  
  scr_w,scr_h =love.graphics.getDimensions()
  --love.window.setMode(80*tile_size,50*tile_size)
  glib.ui.init()


  game.load()
  
  --love.keyboard.setKeyRepeat(true)
end


function love.update(dt)
  game.update(dt)
end

function love.draw()
  game.draw()
end


function love.keypressed(k,s,r)
  game.keyHandle(k,s,r,true)
  if key == "escape" then
    love.event.quit()
  end
  
end

function love.keyreleased(k)
    game.keyHandle(k,0,0,false)
end

function love.mousepressed(x,y,btn,t)
  game.MouseHandle(x,y,btn,t)
end

function love.mousemoved(x,y,dx,dy)
    game.MouseMoved(x,y)
end


