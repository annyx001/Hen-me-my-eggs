local Utils = require("src/utilities")
local Egg = {}


function Egg.new()
    return {
        list = {
            {x = 200, y = 580, collected = false},
            {x = 350, y = 520, collected = false},
            {x = 480, y = 550, collected = false}
        }
    }
end

function Egg.load(eggSystem)
    eggSystem.sprite = love.graphics.newImage("assets/images/egg_sprite.png")
end

function Egg.draw(eggSystem)
    love.graphics.setColor(1, 1, 1, 1)
    local w = eggSystem.sprite:getWidth()
    local h = eggSystem.sprite:getHeight()

    for i, egg in ipairs(eggSystem.list) do
        love.graphics.draw(
            eggSystem.sprite,
            egg.x,
            egg.y,
            0,
            0.05, 0.05,
            w /2,
            h / 2
        )
    end
end

return Egg