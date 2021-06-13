local Helper = {}

-- Refuel the turtle if needed.
function Helper.checkFuel()
  if turtle.getFuelLevel() < 960 then
    turtle.select(16)
    if turtle.getItemCount() > 0 then
      turtle.refuel(16)
    else
      turtle.turnRight()
      turtle.suck(64)
      turtle.turnLeft()
      turtle.refuel(16)
    end
  end
end

function Helper.drop(start, offset)
  turtle.turnLeft()
  for i = slot, offset, 1 do
    turtle.select(slot)
    turtle.transferTo(slot, 64)
  end
  turtle.turnRight()
end

-- Check if the slot of the inventory is present.
function Helper.isItemAt(slot)
  turtle.select(slot)
  local data = "none"

  if turtle.compare() then
    data = "forward"
  elseif turtle.compareUp() then
    data = "up"
  elseif turtle.compareDown() then
    data = "down"
  end

  return data
end

function Helper.down(count)
  for i = 0, count, 1 do
    if turtle.down() == false then
      if turtle.getFuelLevel() == 0 then
        Helper.checkFuel()
        turtle.down()
      else
        break
      end
    end
  end
end

function Helper.place(slot)
  turtle.select(slot)
  turtle.place()
end

return Helper