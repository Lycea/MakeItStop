local sample_state =class_base:extend()

local mod_dir = {}
local mods = {}
local phase_ids = {}
local current_phase = 1

local function recursiveEnumerate(folder, fileTree)
  local lfs = love.filesystem
  local filesTable = lfs.getDirectoryItems(folder)
  for i, v in ipairs(filesTable) do
    local file = folder .. "/" .. v
    if lfs.isFile(file) then
      mod_dir[#mod_dir + 1] = file
    elseif lfs.isDirectory(file) then
      fileTree = fileTree .. "\n" .. file .. " (DIR)"
      fileTree = recursiveEnumerate(file, fileTree)
    end
  end
  return fileTree
end


local function load_scenes()

  --load all the modules
  recursiveEnumerate("states/phases", "")
  
  for _, mod in pairs(mod_dir) do
    --print(mod)
    mod = string.gsub(mod, "/", "."):gsub(".lua", "")
    print( "   loading phase:  "..mod)
    l_mod = require(mod)
    mods[l_mod.id] = l_mod
    table.insert(phase_ids, l_mod.id)
    --mods[l_mod.id]:startup()
  end
end


function sample_state:new()
  load_scenes()
  print("initialised!!")
end

function sample_state:startup()
  mods[phase_ids[current_phase]]:startup()
end

function sample_state:draw()
  mods[phase_ids[current_phase]]:draw()
end

function sample_state:update()
  -- print(mods)
  -- print(phase_ids,#phase_ids)
  -- print(current_phase , phase_ids[current_phase] )
 local ret = mods[phase_ids[current_phase]]:update()
 if ret then
   next_phase = math.min( current_phase+1,#phase_ids )
   if next_phase == current_phase then
   else
     print("phase chang:",next_phase,current_phase)
      mods[phase_ids[current_phase]]:shutdown()
      mods[phase_ids[next_phase]]:startup()
      current_phase = next_phase
   end
 end
end

function sample_state:shutdown()
  
end





return sample_state()
