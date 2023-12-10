local love = require("love")

function love.load()
   local road = {
      v_pipe = love.graphics.newImage("images/roadTexture_01.png"),
      h_pipe = love.graphics.newImage("images/roadTexture_13.png"),
      ne = love.graphics.newImage("images/roadTexture_02.png"),
      nw = love.graphics.newImage("images/roadTexture_03.png"),
      se = love.graphics.newImage("images/roadTexture_14.png"),
      sw = love.graphics.newImage("images/roadTexture_15.png"),
      grass = love.graphics.newImage("images/roadTexture_25.png"),
      size = 128,
      scale = 0.25
   }

   local pipe = {
      v_pipe = love.graphics.newImage("images/pipe-01.png"),
      h_pipe = love.graphics.newImage("images/pipe-13.png"),
      ne = love.graphics.newImage("images/pipe-02.png"),
      nw = love.graphics.newImage("images/pipe-03.png"),
      se = love.graphics.newImage("images/pipe-14.png"),
      sw = love.graphics.newImage("images/pipe-15.png"),
      grass = love.graphics.newImage("images/pipe-25.png"),
      size = 14,
      scale = 0.6
   }

   IMAGES = pipe


   MAP = {}
   local y = 0
   for line in io.lines("../input/day-10.txt") do
      MAP[y] = {}
      local x = 0
      for letter in line:gmatch(".") do
         if letter == "S" then
            letter = "7"
         end
         MAP[y][x] = letter
         x = x + 1
      end
      y = y + 1
   end

   SCALE = IMAGES.scale
   SIZE = IMAGES.size * SCALE

   love.window.setFullscreen(true)
end

function love.draw()
   for y = 0, #MAP do
      for x = 0, #MAP[y] do
         local tile = MAP[y][x]
         if tile == "|" then
            love.graphics.draw(IMAGES.v_pipe, x * SIZE, y * SIZE, 0, SCALE, SCALE)
         elseif tile == "-" then
            love.graphics.draw(IMAGES.h_pipe, x * SIZE, y * SIZE, 0, SCALE, SCALE)
         elseif tile == "F" then
            love.graphics.draw(IMAGES.ne, x * SIZE, y * SIZE, 0, SCALE, SCALE)
         elseif tile == "L" then
            love.graphics.draw(IMAGES.se, x * SIZE, y * SIZE, 0, SCALE, SCALE)
         elseif tile == "7" then
            love.graphics.draw(IMAGES.nw, x * SIZE, y * SIZE, 0, SCALE, SCALE)
         elseif tile == "J" then
            love.graphics.draw(IMAGES.sw, x * SIZE, y * SIZE, 0, SCALE, SCALE)
         else
            love.graphics.draw(IMAGES.grass, x * SIZE, y * SIZE, 0, SCALE, SCALE)
         end
      end
   end
end
