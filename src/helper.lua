local Helper = {}

-- Refuel the turtle if needed.
function Helper.checkFuel()
  if turtle.getFuelLevel() < 96 then
    turtle.select(16)
    if turtle.getItemCount() > 0 then
      turtle.refuel(1)
    else
      turtle.turnRight()
      turtle.suck(64)
      turtle.turnLeft()
      turtle.refuel()
    end
  end
end

-- Check if the slot 15 of the inventory is present.
function Helper.isItemToDig()
  turtle.select(15)
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

function Helper.down(count) {
  for i = 0, count, 1 do
    if turtle.down() == false then
      Helper.checkFuel()
      turtle.down()
    end
  end
}