local Helper = require("helper")

-- Slot 16: Coal
-- Slot 15: Cactus
-- Slot 14: Border
-- Slot 13: Refill (on top) / Drop items (on left)

local direction = "right"

function isCactus()
  return Helper.isItemAt(15) == "down"
end

function isBorder()
  return Helper.isItemAt(14) == "forward"
end

function shouldFill()
  return Helper.isItemAt(13) == "down"
end

-- Functions
function move() 
  if not turtle.forward() and isBorder() then
    if direction == "right" then
      turtle.turnRight()

      if not isBorder() then
        turtle.forward()
        if not isBorder() then
          direction = "left"
        end
      end

      turtle.turnRight()
    elseif direction ==  "left" then
      turtle.turnLeft()

      if not isBorder() then
        turtle.forward()
        if not isBorder() then
          direction = "right"
        end
      end

      turtle.turnLeft()
    end
  end
end

function dropCactus()
  turtle.turnRight()
  if turtle.detect() then
    Helper.drop(1, 12)
    turtle.turnLeft()
  else
    turtle.turnLeft()
    turtle.turnLeft()
    if turtle.detect() then
      Helper.drop(1, 12)
      turtle.turnRight()
    end
  end
end

-- Start
while true do
  if shouldFill() then
    Helper.checkFuel()
    dropCactus()
  elseif isCactus() then
    turtle.select(1)
    turtle.digDown()
  end

  move()
end
