-- Import libraries.
local Object = require("libs.classic")

-- Import screens.
local Screen_AnimationCreator = require("src.gui.screens.AnimationCreator")
---------------------------------------------------------------------------

local GameController = Object:extend()

function GameController:new()
    -- Init variables
    _G.QUAKE_MODE = false

    _G.GAME_PATHS = {
        playerModels = {
            heads  = "assets/characterModels/heads/",
            arms   = "assets/characterModels/arms/",
            bodies = "assets/characterModels/bodies/",
            legs   = "assets/characterModels/legs/",
        }
    }

    _G.ASSETS = {
        fonts = {
            ui = love.graphics.newFont(18)
        }
    }

    _G.COLORS = {
        darkGrey = "#6b6b6b",
        lightGrey = "#969696",
        black = "#000000"
    }

    _G.UI_SCREEN = Screen_AnimationCreator()
end

function GameController:update(dt)
    if (love.keyboard.isDown("escape")) then
        love.event.quit()
    end

    love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))

    _G.UI_SCREEN:update(dt)
end

function GameController:draw()
    _G.UI_SCREEN:draw()
end

function GameController:keypressed(key, scancode, isrepeat)
    _G.UI_SCREEN:keypressed(key, scancode, isrepeat)
end

function GameController:mousemoved(x, y, dx, dy)
    _G.UI_SCREEN:mousemoved(x, y, dx, dy) 
end

function GameController:mousepressed(x, y, button, isTouch, presses)
    _G.UI_SCREEN:mousepressed(x, y, button, isTouch, presses)
end

return GameController