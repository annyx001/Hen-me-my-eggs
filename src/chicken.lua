local Utils = require("src/utilities")
local Chicken = {}

function Chicken.new(x,y)
    return{
        x = x,
        y = y,
        groundY = y,
        speed = 200,
        isMoving = false,
        currentSprite = "right",
        isJumping = false,
        jumpTimer = 0,
        jumpDuration = 0.5, -- seconds for full jump arc
        jumpHeight = 100,   -- pixels high at peak
    }
end

function Chicken.load(chicken)  
    -- Load in sprite sheets
    chicken.idleSprites = {
        right = love.graphics.newImage("assets/images/chicken_idle_right_sprite.png"),
        left = love.graphics.newImage("assets/images/chicken_idle_left_sprite.png")
    }

    chicken.walkSprites = {
        left = love.graphics.newImage("assets/images/chicken_walking_left_sprite.png"),
        right = love.graphics.newImage("assets/images/chicken_walking_right_sprite.png")
    }

    -- Define animation settings
    chicken.animationSettings = {
        frameWidth = 490,
        frameHeight = 560,
        cols = 4,
        rows = 4,           
        totalFrames = 16,   -- total frames in sprite sheet
        currentFrame = 1,
        timer = 0,
        speed = 0.075
    }
end

function Chicken.update(chicken, dt)
    chicken.isMoving = false

    -- Move RIGHT (right arrow)
    if love.keyboard.isDown("right") then
        chicken.x = chicken.x + chicken.speed * dt
        chicken.isMoving = true
        chicken.currentSprite = "right"
    end

    -- Move LEFT (left arrow)
    if love.keyboard.isDown("left") then
        chicken.x = chicken.x - chicken.speed * dt
        chicken.isMoving = true
        chicken.currentSprite = "left"
    end

    -- JUMP UP (up arrow)
    if love.keyboard.isDown("up") and not chicken.isJumping then
        chicken.isJumping = true
        chicken.jumpTimer = 0
    end

    if chicken.isJumping then
        chicken.jumpTimer = chicken.jumpTimer + dt

        local arc = math.sin(chicken.jumpTimer / chicken.jumpDuration * math.pi)
        chicken.y = chicken.groundY - (arc * chicken.jumpHeight)

        -- Landing check
        if chicken.jumpTimer >= chicken.jumpDuration then
            chicken.isJumping = false
            chicken.jumpTimer = 0
            chicken.y = chicken.groundY  -- snap back to ground
        end
    end

    -- Update animation
    Utils.updateAnimation(chicken.animationSettings, dt)
end

function Chicken.draw(chicken)
    if chicken.idleSprites then
        love.graphics.setColor(1,1,1,1)  -- white color for sprite so shows in original colors of the image
        local scalex = 0.12  -- scale sprite's size (x direction)
        local scaley = 0.12  -- scale sprite's size (y direction)

        --Get current direction and animation
        local walkSprite = chicken.walkSprites[chicken.currentSprite]
        
        -- Draw walking animation
        if chicken.isMoving and walkSprite then
            local frameCrop = Utils.getFrameCrop(walkSprite, chicken.animationSettings)
            love.graphics.draw(
                walkSprite,
                frameCrop,
                chicken.x,
                chicken.y,
                0,
                scalex, scaley,
                chicken.animationSettings.frameWidth / 2,
                chicken.animationSettings.frameHeight / 2
            )
        else
            --If not moving (idle)
            local idleSprite = chicken.idleSprites[chicken.currentSprite]
            local w = idleSprite:getWidth()
            local h = idleSprite:getHeight()

            love.graphics.draw(
                idleSprite,
                chicken.x,
                chicken.y,
                0,
                scalex, scaley,
                w / 2,
                h / 2
            )
        end

    end

end

function Chicken.reset(chicken)
    chicken.isMoving = false
    chicken.currentSprite = "right"
end

return Chicken


