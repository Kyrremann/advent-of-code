local love = require("love")

function love.load()
   love.window.setFullscreen(true)
   width = 101
   height = 103
   screen_width = love.graphics.getWidth()
   screen_height = love.graphics.getHeight()
   do_math = true
   timer = 0
   seconds = 0
   counter = 0

   data = {}
   draw = {}
   size = 1
   offset = 13
   local pattern = 'p=(%d+),(%d+) v=(%-?%d+),(%-?%d+)'

   for line in io.lines('../input/14') do
	  for px, py, vx, vy in string.gmatch(line, pattern) do
		 -- print(px, py, vx, vy)
		 table.insert(data, {px=px, py=py, vx=vx, vy=vy})
	  end
   end

   for i = 0, 8*13 do
	  draw[i] = {}
	  for _,v in pairs(data) do
		 if i == 0 then
			table.insert(draw[i], {px = v.px, py = v.py, vx = v.vx, vy = v.vy})
		 else
			px = v.px
			py = v.py
			for _ = 0, i do
			   px = (px + v.vx) % width
			   py = (py + v.vy) % height
			end

			table.insert(draw[i], {px = px, py = py, vx = v.vx, vy = v.vy})
		 end
	  end
   end

   -- for _ = 0, width*height do
   for _ = 0, 7382 do -- first frame is the tree
   	  seconds = seconds + (8*13)
   	  next()
   end

   love.graphics.setColor(30, 121, 44)
end

function next()
   for _,t in pairs(draw) do
	  for i,v in pairs(t) do
		 v.px = (v.px + v.vx) % width
		 v.py = (v.py + v.vy) % height
	  end
   end
end

function previous()
   for _,t in pairs(draw) do
	  for i,v in pairs(t) do
		 v.px = (v.px - v.vx) % width
		 v.py = (v.py - v.vy) % height
	  end
   end
end

function love.update(delta)
   if false then
	  timer = timer + delta
	  if timer > .1 then
		 timer = 0

		 if do_math then
			seconds = seconds + 1

			for i,v in pairs(data) do
			   v.px = (v.px + v.vx) % width
			   v.py = (v.py + v.vy) % height
			end
		 end
	  end
   end
end

function love.draw(delta)
   local from = seconds
   local to = from + (8*13)--counter + (seconds * (8*13))
   love.graphics.print("Seconds: " .. seconds .. "-" .. to, 1, screen_height - 20)

   for y = 0, 7 do
	  y = y * height + (y * offset)

	  for x = 0, 12 do
		 x = x * width + (x * offset)
		 -- to = to + 1

		 from = from + 1
		 love.graphics.print(from, x + width, y + height)

		 -- print(counter, seconds, from, to)
		 
		 for _,v in pairs(draw[from-1-seconds]) do
			-- px = v.px
			-- py = v.py

--			for _ = counter, to do
--			   px = (px + v.vx) % width
--			   py = (py + v.vy) % height			   
--			end
			
			love.graphics.rectangle('fill',
									(v.px * size) + x,
									(v.py *size) + y,
									size, size)
		 end
	  end
   end
end

function love.keypressed(key, scancode, isrepeat)   
   if key == 'escape' then
	  love.event.quit()
   elseif key == 'right' then
	  do_math = false
	  seconds = seconds + (8*13)
	  next()
   elseif key == 'left' then
	  do_math = false
	  seconds = seconds - (8*13)
	  previous()
   elseif key == 'space' then
	  do_math = not do_math
   end
end
