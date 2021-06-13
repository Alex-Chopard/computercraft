local Helper = require("helper")

-- Slot 16: Coal
-- Slot 15: Birch Wood
-- Slot 14: Birch Leaves
-- Slot 13: Birch Sapling

-- Slot: 12: Forward
-- Slot: 11: Turne right
-- Slot: 10: Turne left
-- Slot: 9: Fuel refill and drop items (rigth fuel, left items)

-- Functions

function move()
  if Helper.isItemAt(12) == "down" then
    turtle.forward()
  elseif Helper.isItemAt(11) == "down" then
    turtle.turnRight()
    turtle.forward()
  elseif Helper.isItemAt(10) == "down" then
    turtle.turnLeft()
    turtle.forward()
  end
end

function digLeavesAround() 
  if Helper.isItemAt(14) == "forward" then
    if Helper.isItemAt(14) == "forward" then
      turtle.select(13)
      turtle.dig()
    end
    turtle.turnRight()

    if Helper.isItemAt(14) == "forward" then
      turtle.select(13)
      turtle.dig()
    end
    turtle.turnRight()

    if Helper.isItemAt(14) == "forward" then
      turtle.select(13)
      turtle.dig()
    end
    turtle.turnRight()

    if Helper.isItemAt(14) == "forward" then
      turtle.select(13)
      turtle.dig()
    end
    turtle.turnRight()
  end
end

-- The Turtle has to be infront of the tree.
function digTree()
  if Helper.isItemAt(15) == "forward" then
    turtle.select(1)
    turtle.dig()
    turtle.forward()
    -- Dig wood
    while Helper.isItemAt(15) == "up" do
      turtle.select(1)
      turtle.digUp()
      turtle.up()
      digLeavesAround()
    end
    -- Dig leaves
    while Helper.isItemAt(14) == "up" do
      turtle.select(13) -- Place sapling
      turtle.digUp()
      turtle.up()
      digLeavesAround()
    end
    -- Go down
    Helper.down(20)
    turtle.back()
    Helper.place(13) -- Place sapling
  else
    Helper.place(13) -- Place sapling
  end
end

-- Start
while true do
  if Helper.isItemAt(12) == "down" then -- Normal
    turtle.turnRight()
  
    digTree()
  
    turtle.turnLeft()
    turtle.turnLeft()
  
    digTree()
  
    turtle.turnRight()
    move()
  elseif Helper.isItemAt(11) == "down" then  -- In turn right
    digTree()

    turtle.turnLeft()
    digTree()

    turtle.turnRight()
    move()
  elseif Helper.isItemAt(10) == "down" then  -- In turn left
    digTree()
    turtle.turnRight()
    digTree()

    turtle.turnLeft()
    move()
  elseif Helper.isItemAt(9) == "down" then  -- Refill
    Helper.checkFuel()
    Helper.drop(1, 8)
    io.sleep(60)
    turtle.forward()
  end
end

