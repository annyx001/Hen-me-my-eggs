local Chicken = require("src/chicken")
local Egg = require("src/egg")

function love.load()
    chicken = Chicken.new(40, SCREEN_HEIGHT - 40)
    Chicken.load(chicken)

    eggSystem = Egg.new()
    Egg.load(eggSystem)
end

function love.update(dt)
    Chicken.update(chicken, dt)
end

function love.draw()
    Chicken.draw(chicken)
    Egg.draw(eggSystem)
end

