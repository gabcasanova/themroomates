-- Import libraries.
local Object = require("libs.classic")
--------------------------------------

local GameController = Object:extend()

function GameController:new()
    _G.GAME_PATHS = {
        playerModels = {
            heads  = "assets/characterModels/heads/",
            arms   = "assets/characterModels/arms/",
            bodies = "assets/characterModels/bodies/",
            legs   = "assets/characterModels/legs/",
        }
    }
end

function GameController:update(dt)
    if (love.keyboard.isDown("escape")) then
        love.event.quit()
    end
end

function GameController:draw()
    --
end

return GameController