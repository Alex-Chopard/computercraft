local Helper = require("helper")

-- Slot 16: Coal
-- Slot 15: Birch Wood
-- Slot 14: Birch Sapling

-- Slot: 13: Forward
-- Slot: 12: Turne right
-- Slot: 11: Turne left
-- Slot: 10: Fuel refill and drop items (rigth fuel, left items)

-- Variables
local fuelUsed = 0
local fuelAtBeggin = 0
local fuelAtEnd = 0
local logDigged = 0
local logDiggedLastLoop = 0
local treeDigged = 0
local treeDiggedLastLoop = 0

function hasWoodAtUp()
  turtle.select(15)
  return turtle.compareUp()
end

function hasWoodAtFront()
  turtle.select(15)
  return turtle.compare()
end

function shouldForward()
  return Helper.isItemAt(13) == "down"
end

function shouldRight()
  return Helper.isItemAt(12) == "down"
end

function shouldLeft()
  return Helper.isItemAt(11) == "down"
end

function shouldRefill()
  return Helper.isItemAt(10) == "down"
end

-- Functions
function printStatistics()
  print("***************************************")
  print("        " .. os.date("%d.%m.%Y %H:%M"))
  print("Fuel level: " .. turtle.getFuelLevel())
  print("Fuel used: " .. fuelUsed)
  print("Fuel used last loop: " .. fuelAtBeggin - fuelAtEnd)
  print("Log digged: " .. logDigged)
  print("Log digged last loop: " .. logDiggedLastLoop)
  print("Tree digged: " .. treeDigged)
  print("Tree digged last loop: " .. treeDiggedLastLoop)
  print("***************************************")
end

function move()
  if shouldForward() then
    Helper.forward(1)
  elseif shouldRight() then
    turtle.turnRight()
    Helper.forward(1)
  elseif shouldLeft() then
    turtle.turnLeft()
    Helper.forward(1)
  end
end

-- The Turtle has to be infront of the tree.
function digTree()
  if hasWoodAtFront() then
    upCount = 0
    turtle.select(1)
    turtle.dig()
    logDiggedLastLoop = logDiggedLastLoop + 1
    Helper.forward(1)
    -- Dig wood
    while hasWoodAtUp() do
      turtle.select(1)
      turtle.digUp()
      logDiggedLastLoop = logDiggedLastLoop + 1
      Helper.up(1)
      upCount = upCount + 1
    end
    -- Go down
    if upCount > 0 then
      Helper.down(upCount)
    end
    Helper.back(1)
    Helper.place(14) -- Place sapling
    treeDiggedLastLoop = treeDiggedLastLoop + 1
  else
    Helper.place(14) -- Place sapling
  end
end

function getSapling()
  turtle.select(14)
  if turtle.getItemCount() <= 32 then
    turtle.turnRight()
    turtle.suck(32)
    turtle.turnLeft()
  end
end

-- Start
while true do
  
  if shouldForward() then -- Normal
    turtle.turnRight()
  
    digTree()
  
    turtle.turnLeft()
    turtle.turnLeft()
  
    digTree()
  
    turtle.turnRight()
    move()
  elseif shouldRight() then  -- In turn right
    digTree()

    turtle.turnLeft()
    digTree()

    turtle.turnRight()
    move()
  elseif shouldLeft() then  -- In turn left
    digTree()
    turtle.turnRight()
    digTree()

    turtle.turnLeft()
    move()
  elseif shouldRefill() then  -- Refill
    fuelAtEnd = turtle.getFuelLevel()
    fuelUsed = fuelAtBeggin - fuelAtEnd
    logDigged = logDigged + logDiggedLastLoop
    treeDigged = treeDigged + treeDiggedLastLoop
    printStatistics()
    fuelAtBeggin = turtle.getFuelLevel()
    logDiggedLastLoop = 0 -- New loop
    treeDiggedLastLoop = 0 -- New loop

    Helper.checkFuel()

    turtle.turnLeft()
    Helper.drop(1, 9)
    turtle.turnRight()

    getSapling()
    Helper.forward(1)
  end
end

