local Chicken = require("src/chicken")

function love.load()
    chicken = Chicken.new(40, SCREEN_HEIGHT - 40)
    Chicken.load(chicken)
end

function love.update(dt)
    Chicken.update(chicken, dt)
end

function love.draw()
    Chicken.draw(chicken)
end

