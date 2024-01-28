local sceen = class_base:extend()


function sceen:new()
  self.dialogues = {}
  print("initialised sceen helper!!")

  self.__dialog_step = 1
  self.__timer = glib.timer(1)
  self.active = false
end

function line(txt)
  return { t="line", txt = txt}
end

function wait(sec)
  return { t = "wait", time = sec }
end

function clear()
  return { t = "clear" }
end

function sceen:load_file(file_path)
  --local fi_handle = io.open(file_path, "r")
  local fi_handle =  love.filesystem.read(file_path)

  local dialoges ={}
  local tmp_dialog = {}

  self.dialogues = {}


  for line_ in love.filesystem.lines(file_path) do
    if string.match(line_,"^-*$") ~= nil then
      if #tmp_dialog >0 then
        table.insert(dialoges, tmp_dialog)
        tmp_dialog = {}
      end
    else
      command = string.match(line_, ">>(.*)")
      if command then
        print("comm: " .. command)
        if command == "new_dialog" then
          table.insert(tmp_dialog, clear())
        elseif string.find(command, "wait") then
          table.insert(tmp_dialog, wait(tonumber(string.match(command, "wait (.*)"))))
        end
      else
        table.insert(tmp_dialog, line(line_))
      end
    end
  end
  self.dialogues = dialoges
end

function sceen:start(idx)
  self.__dialog_step = idx
  self.__sub_step = 1
  self.__between = true
  self.__timer = glib.timer(2)
  self.__waiting = true

  self.active = true

  glib.console.clear()
  glib.console.setPos(0, scr_h - 200)
  glib.console.setSize(scr_w, 200)
end

function sceen:show()
  glib.console.draw()
end

function sceen:update()
  if self.active == false then
    return
  end
  local wait_done = false
  if self.__waiting then
    wait_done = self.__timer:check()
  end
  --wait check 
  if wait_done then
    self.__waiting = false
    self.__between = false
  else
    return false
  end

  --do what should be done in the step or initialise wait
  step_tmp = self.dialogues[self.__dialog_step][self.__sub_step]
  step_type = step_tmp.t
  if step_type == "line"  then
    self.__waiting = true
    self.__between = true
    self.__timer = glib.timer(3)
    glib.console.print(step_tmp.txt)
  elseif step_type == "wait" then
    self.__waiting = true
    self.__timer= glib.timer(step_tmp.time)
  elseif step_type == "clear" then
    glib.console.clear()
    self.__waiting = true
    self.__between = true
    self.__timer= glib.timer(0.5)
  end

  self.__sub_step = self.__sub_step+1
  if self.__sub_step > #self.dialogues[self.__dialog_step] then
    self.active = false
    return true
  end
end

return sceen()
