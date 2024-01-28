local helper ={}

function helper.do_when( a , b, fn_call)
  if a==b then
    fn_call()
  end
end



function helper.draw_countdown(percent_left)
  bar_w = 600
  border_w = bar_w + 10

  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.rectangle("fill", 90, 45, border_w, 40)
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.rectangle("fill", 95, 50, bar_w, 30)
  love.graphics.setColor(255, 255, 255, 255)

  full_width = bar_w
  rest_width = math.max(full_width - (full_width * 0.01) * percent_left, 0)

  love.graphics.rectangle("fill", 95, 50, rest_width, 30)
  love.graphics.setColor(255, 255, 255, 255)
end

return helper
