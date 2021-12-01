function lines_from(filename)
   lines = {}
   for line in io.lines(filename) do 
      lines[#lines + 1] = line
   end
   return lines
end

printf = function(s,...)
   return io.write(s:format(...) .. "\n")
end

table.reduce = function (list, fn, init)
   local acc = init
   for k, v in ipairs(list) do
      if 1 == k and not init then
         acc = v
      else
         acc = fn(acc, v)
      end
   end
   return acc
end


function star_1(contents)
   local prev = contents[1]
   local increments = 0
   for _,line in pairs(contents) do
      if line > prev then
         increments = increments + 1
      end
      prev = line
   end

   printf("There are %d measurements larger than the previous measurement", increments)
   return increments
end

local test_data_1 = {199, 200, 208, 210, 200, 207, 240, 269, 260, 263}
assert(star_1(test_data_1) == 7, 'Star1: There should be 7 increments')

local contents = lines_from('input/day-01.txt')
star_1(contents) -- off by one :/


function star_2(content)
   local sums = {}
   for i=1, #content do
      local set = {table.unpack(content, i, i+2)}
      if #set < 3 then
         break
      end

      sum = table.reduce(
         set,
         function (a, b)
            return a + b
         end
      )
      table.insert(sums, sum)
   end

   return star_1(sums)
end

assert(star_2(test_data_1) == 5, 'Star1: There should be 5 increments')
star_2(contents)
