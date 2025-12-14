if arg[2] == "debug" then
    require("lldebugger").start()
end

-- io.stdout:setvbuf("no") -- Enable printing in debug.

-- Import Libraries:
local g3d = require("libs.g3d")

-- Import Classes:
local GameController = require("src.GameController")
local Player = require("src.Player")

_G.GAME_CONTROLLER = GameController()
----------------------------------------------------

local Player1
local background = g3d.newModel("assets/models/sphere.obj", "assets/textures/starfield.png", {0,0,0}, nil, {500,500,500})

function love.load()
    Player1 = Player()
    print("aaaaa")
end

function love.update(dt)
    Player1:update(dt)
    _G.GAME_CONTROLLER:update(dt)
    g3d.camera.firstPersonMovement(dt)
end

function love.draw()
    background:draw()
    Player1:draw()
    _G.GAME_CONTROLLER:draw()
end

function love.mousemoved(x, y, dx, dy)
    --g3d.camera.firstPersonLook(dx,dy)
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