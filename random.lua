--[[
   Defines many useful random functions
   OBS: you need to set a seed with random.set_seed before using any other functions
]]

if random then return end
local random = {}

-- Sets the seed for random numbers
-- If no arguments, uses current time to set the seed
-- @param seed (nil, number): seed for random values; if nil, uses current time
-- @return: none
function random.set_seed(seed)
   if seed then math.randomseed(seed)
   else math.randomseed(os.time()) end
end

-- Returns a random float between 0 and 1
-- Uniformly distributed
-- @param: none
-- @return (number): float between 0 and 1
function random.random()
   return math.random()
end

-- Returns a random integer between a and b (inclusive)
-- Uniformly distributed
-- @param a (number): smallest possible integer value
-- @param b (number): highest possible integer value
-- @return (number): integer between a and b (inclusive)
function random.randint(a, b)
   return math.random(a, b)
end

-- Returns a random float between a and b
-- Uniformly distributed
-- @param a (number): smallest possible float value
-- @param b (number): highest possible float value
-- @return (number): float between a and b
function random.randfloat(a, b)
   return math.random() * (b - a) + a
end

-- Returns a random choice from given table
-- Uniformly distributed
-- Assumes table is an array-like (keys are 1, 2, .., #array)
-- @param array (table): array-like table
-- @return (any): a value from array
function random.choice(array)
   return array[random.randint(1, #array)]
end

-- Returns a random choice from given table and removes it
-- Uniformly distributed
-- OBS: changes the given array!
-- Assumes table is an array-like (keys are 1, 2, .., #table)
-- @param array (table): array-like table
-- @return (any): a value from array
function random.delete(array)
   local i = random.randint(1, #array)
   local value = array[i]
   table.remove(array, i)
   return value
end

-- Returns a shuffled version of given table
-- OBS: does not alter original array
-- Assumes table is an array-like (keys are 1, 2, .., #table)
-- @param array (table): array-like table
-- @return (table): same values of original array, but with keys swapped
function random.shuffle(array)
   local array_copy = {}
   for k, v in pairs(array) do
      array_copy[k] = v
   end
   for i = #array_copy, 2, -1 do
      local j = random.randint(1, i)
      array_copy[i], array_copy[j] = array_copy[j], array_copy[i]
    end
    return array_copy
end

-- Returns true with probability p
-- OBS: p must be between 0 and 1
-- @param p (number): probability of returning true
-- @return (boolean): true or false
function random.probability(p)
   return random.random() < p
end

-- Returns a key k with probability prob[k]
-- OBS: keys can be any value
-- @param prob (table): prob[k] represents the probability of choosing the key k
-- @return (any): a key from table prob
function random.distribution(prob)
   local p = random.random()
   local last = 0
   for k, v in pairs(prob) do
      if p < v then
         return k
      end
      p = p - v
      last = k
   end
   return last
end

-- Generates a random number from a normal distribution
-- OBS: based on this article: https://en.wikipedia.org/wiki/Normal_distribution#Generating_values_from_normal_distribution
-- @param mean (number): mean of the normal distribution
-- @return std (number): standard deviation of the normal distribution
-- @return (number): a number based on the normal distribution with mean <mean> and standard deviation <std>
function random.normal(mean, std)
   local u = random.randfloat(0, 1)
   local v = random.randfloat(0, 1)
   local z = math.sqrt(-2 * math.log(u)) * math.cos(2 * math.pi * v)
   return z * std + mean
end

return random