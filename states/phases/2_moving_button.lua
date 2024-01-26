local phase =class_base:extend()


function phase:new()
  self.id = 2
  print("initialised start screen!!")
end

function phase:startup()
end





function phase:draw()
  
end



function phase:update()
  return true
end

function phase:shutdown()
    
end





return phase()
