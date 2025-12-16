if arg[2] == "debug" then
    require("lldebugger").start()
end

-- io.stdout:setvbuf("no") -- Enable printing in debug.

-- Import Classes:
local GameController = require("src.GameController")
----------------------------------------------------

function love.load()
    _G.GAME_CONTROLLER = GameController()
end

function love.update(dt)
    _G.GAME_CONTROLLER:update(dt)
end

function love.draw()
    _G.GAME_CONTROLLER:draw()
end

function love.keypressed(key, scancode, isrepeat)
    _G.GAME_CONTROLLER:keypressed(key, scancode, isrepeat)
end

function love.mousemoved(x, y, dx, dy)
    _G.GAME_CONTROLLER:mousemoved(x, y, dx, dy)
end

function love.mousepressed(x, y, button, isTouch, presses)
    _G.GAME_CONTROLLER:mousepressed(x, y, button, isTouch, presses)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end