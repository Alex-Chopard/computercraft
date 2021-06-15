local Helper = {}

-- Refuel the turtle if needed.
function Helper.checkFuel()
  print("Fuel level: " .. turtle.getFuelLevel())
  if turtle.getFuelLevel() < 960 then
    turtle.select(16)
    if turtle.getItemCount() > 0 then
      turtle.refuel(16)
    else
      turtle.suckUp(64)
      turtle.refuel(16)
    end
  end
end

function Helper.drop(start, offset)
  for slot = start, offset, 1 do
    turtle.select(slot)
    turtle.drop()
  end
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

function Helper.place(slot)
  turtle.select(slot)
  turtle.place()
end

-- Movment
function Helper.forward(count)
  for i = 1, count, 1 do
    if not turtle.forward() then
      turtle.dig()
      turtle.attack()
      i = i + 1
    end
  end
end

function Helper.down(count)
  for i = 1, count, 1 do
    if not turtle.down() then
      turtle.digDown()
      turtle.attackDown()
      i = i + 1
    end
  end
end

function Helper.up(count)
  for i = 1, count, 1 do
    if not turtle.up() then
      turtle.digUp()
      turtle.attackUp()
      i = i + 1
    end
  end
end

function Helper.back(count)
  for i = 1, count, 1 do
    if not turtle.back() then
      turtle.turnRight()
      turtle.turnRight()
      turtle.dig()
      turtle.attack()
      turtle.turnRight()
      turtle.turnRight()
      i = i + 1
    end
  end
end

return Helper