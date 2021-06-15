local Helper = require("helper")

-- Slot 16: Coal
-- Slot 15: Birch Wood
-- Slot 14: Birch Sapling

-- Slot: 13: Forward
-- Slot: 12: Turne right
-- Slot: 11: Turne left
-- Slot: 10: Fuel refill and drop items (rigth fuel, left items)

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
    Helper.forward(1)
    -- Dig wood
    while hasWoodAtUp() do
      turtle.select(1)
      turtle.digUp()
      Helper.up(1)
      upCount = upCount + 1
    end
    -- Go down
    if upCount > 0 then
      Helper.down(upCount)
    end
    Helper.back(1)
    Helper.place(14) -- Place sapling
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
    Helper.checkFuel()

    turtle.turnLeft()
    Helper.drop(1, 9)
    turtle.turnRight()

    getSapling()
    Helper.forward(1)
  end
end

