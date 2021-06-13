local Helper = require("helper")

-- Functions

-- The Turtle has to be infront of the tree.
function digTree()
  turtle.select(1)
  turtle.dig()
  turtle.forward()

  while Helper.isItemToDig() == "up" do
    turtle.digUp()
    turtle.up()
  end

  Helper.down(20)
  turtle.back()
end

-- Start
while true do

  if Helper.isItemToDig() == "forward" do
    Helper.checkFuel()

    digTree()
  end

end
