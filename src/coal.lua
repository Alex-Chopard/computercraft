local Helper = require("helper")

-- Slot 16: Coal
-- Slot 15: Furnace

-- Slot 14: Border
-- Slot 13: Refill (top: Fuel, right: Log, left: Coal)

local DIRECTION_TYPE = {
  RIGHT = "right",
  LEFT = "left",
}

local ACTION_TYPE = {
  FILL_LOG = "fillLog",
  RETRIEVE_COAL = "retrieveCoal"
}

local direction = DIRECTION_TYPE.RIGHT
local action = ACTION_TYPE.FILL_LOG

function hasFurnaceDown()
  return Helper.isItemAt(15) == "down"
end

function hasFurnaceUp()
  return Helper.isItemAt(15) == "up"
end

function shouldTurn()
  return Helper.isItemAt(14) == "forward"
end

function shouldRefill()
  return Helper.isItemAt(13) == "down"
end

-- Functions
function fillLog()
  for slot = 1, 12, 1 do
    turtle.select(slot)
    turtle.dropDown()
  end
end

function fillCoal()
  for slot = 1, 12, 1 do
    turtle.select(slot)
    turtle.dropUp()
  end
end

function dropLog()
  turtle.turnRight()
  for slot = 1, 12, 1 do
    turtle.select(slot)
    if turtle.getItemCount() > 0 then
      turtle.drop()
    end
  end
  turtle.turnLeft()
end

function dropCoal()
  turtle.turnLeft()
  for slot = 1, 12, 1 do
    turtle.select(slot)
    if turtle.getItemCount() > 0 then
      -- Drop in the fuel chest first, then in the storage.
      if not turtle.dropUp() then
        turtle.drop()
      end
    end
  end

  turtle.turnRight()
end

function retriveLog()
  turtle.turnRight()
  turtle.select(1)
  for i = 1, 12, 1 do
    if not turtle.suck() then
      break -- break if chest empty
    end
  end
  turtle.turnLeft()
end

function retrieveCoal()
  turtle.turnLeft()
  turtle.select(1)
  for i = 1, 12, 1 do
    if not turtle.suck() then
      break -- break if chest empty
    end
  end
  turtle.turnRight()
end

function refillAndDrop()
  Helper.checkFuel() -- Chest at up.
  -- Drop items
  if action == ACTION_TYPE.FILL_LOG then
    dropLog()
  elseif action == ACTION_TYPE.RETRIEVE_COAL then
    dropCoal()
  end
end

function goToRefill()
  if action == ACTION_TYPE.FILL_LOG then
    Helper.forward(1)
    turtle.turnRight()
    Helper.forward(1)
    Helper.down(2)
    Helper.forward(1)
    turtle.turnRight()
    turtle.turnRight()
  elseif action == ACTION_TYPE.RETRIEVE_COAL then
    turtle.turnRight()
    Helper.forward(2)
    turtle.turnRight()
    turtle.turnRight()
  end
end

function goToPath()
  if action == ACTION_TYPE.FILL_LOG then
    Helper.forward(1)
    Helper.up(2)
    Helper.forward(1)
  elseif action == ACTION_TYPE.RETRIEVE_COAL then
    Helper.forward(3)
  end
end

-- Start

while true do
  if action == ACTION_TYPE.FILL_LOG and hasFurnaceDown() then
    fillLog()
  elseif action == ACTION_TYPE.RETRIEVE_COAL and hasFurnaceUp() then
    turtle.select(1)
    turtle.suckUp()
    fillCoal()
  end

  if shouldRefill() then
    goToRefill()

    -- Also end of a loop!
    refillAndDrop()

    if action == ACTION_TYPE.FILL_LOG then
      action = ACTION_TYPE.RETRIEVE_COAL
      retrieveCoal()
    elseif action == ACTION_TYPE.RETRIEVE_COAL then
      action = ACTION_TYPE.FILL_LOG
      retriveLog()
    end

    goToPath()
  elseif shouldTurn() then
    turtle.turnLeft()
    Helper.forward(1)
  else
    Helper.forward(1)
  end
end