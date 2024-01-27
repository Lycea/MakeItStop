local anima = class_base:extend()



local function loadTiles(file, width, height)
  --not sure if line is needed could be done as temp
  --tilesets_img[count+1]= gr.newImage(file

  local image = love.graphics.newImage(file)

  -- get hight / width of the tile atlas // image
  local img_h = image:getHeight()
  local img_w = image:getWidth()

  height = height or img_h
  width = width or img_w

  -- calc rows /lines
  local rows = math.floor(img_h / height)
  local cols = math.floor(img_w / width)

  local count = 1

  local quadset = {}

  local x_ = 0
  local y_ = 0


  --set also the image to the set ~
  quadset["image"] = image

  for i = 1, rows do
    quadset[i] = {}
    for j = 1, cols do
      quadset[i][j] = love.graphics.newQuad(x_, y_, width, height, img_w, img_h)
      count = count + 1
      x_ = x_ + height
    end
    x_ = 0
    y_ = y_ + height
  end

  return quadset
end

--anima libera ...
function anima:new()
  self.__loaded_files = {}
  self.__anims ={}
end

function anima:load_file(file_path, name, options)
    self.__loaded_files[name] = loadTiles(file_path, options.w, options.h)
end


--sample structure
-- s={
--   {
--     "walk",{1},{1,5},{0.2}
--   },
--   {
--     "run",{2},{1,3},{0.1}
--   }
-- }
function anima:gen_animations(base_name, sub_info_table)
  if self.__loaded_files[base_name] == nil then
    print("Did not find quad set with name " .. base_name)
    return false
  end

  for sub_struct in pairs(sub_info_table) do
    self.__anims[sub_struct[1]] = {
      quad_y = sub_struct[2],
      frame_start = sub_struct[3][1],
      frame_end = sub_struct[3][2],
      anim_speed = sub_struct[4]
    }
  end
end



return anima
