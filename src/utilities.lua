-- Shared utilities for the game (getFrameCrop for sprite and update sprite animation)
local Utils = {}

-- Calculate the frame crop (viewport) for current animation frame
function Utils.getFrameCrop(spriteSheet, animationSettings)
    local frameIndex = animationSettings.currentFrame - 1 -- conver to based 0
    local col = frameIndex % animationSettings.cols
    local row = math.floor(frameIndex / animationSettings.cols)

    return love.graphics.newQuad(
        col* animationSettings.frameWidth,
        row* animationSettings.frameHeight,
        animationSettings.frameWidth,
        animationSettings.frameHeight,
        spriteSheet:getWidth(),
        spriteSheet:getHeight()
    )
end

-- Update animation framed based on timer
function Utils.updateAnimation(animationSettings, dt)
    animationSettings.timer = animationSettings.timer + dt -- increment the timer

    -- If timer exceeds threshold then move on to next frame and reset timer
    if animationSettings.timer >= animationSettings.speed then
        animationSettings.timer = 0
        animationSettings.currentFrame = animationSettings.currentFrame + 1
    end

    -- If we reach the end of spritesheet then loop back to beginning
    if animationSettings.currentFrame > animationSettings.totalFrames then
        animationSettings.currentFrame = 1
    end
end

return Utils