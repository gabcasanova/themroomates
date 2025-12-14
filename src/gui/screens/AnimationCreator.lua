-- Import libraries:
local Object = require("libs.classic")
local g3d = require("libs.g3d")

-- Import Scripts:
-- Import GUI Elements
local Button = require("src.gui.Button")
-- Import Game Objects
local Character = require("src.Character")
--------------------------------------

local AnimationCreator = Object:extend()

function AnimationCreator:new()
    self.background = g3d.newModel("assets/models/sphere.obj", "assets/textures/starfield.png", {0,0,0}, nil, {500,500,500})
    self.objects = {
        character = Character()
    }

    self.gui = {
        testButton = Button()
    }
end

function AnimationCreator:update(dt)
    -- Update GameObjects.
    for index, object in pairs(self.objects) do
        object:update(dt)
    end
    
    -- Update GUI.
    for index, button in pairs(self.gui) do
        button:update(dt)
    end
end

function AnimationCreator:draw()
    -- Draw GameObjects.
    self.background:draw()
    for index, object in pairs(self.objects) do
        object:draw()
    end

    -- Draw GUI.
    for index, button in pairs(self.gui) do
        button:draw()
    end
end

function AnimationCreator:mousepressed(x, y, _button, isTouch, presses)
    -- Mouse GUI.
    for index, button in pairs(self.gui) do
        button:mousepressed(x, y, _button, isTouch, presses)
    end
end

return AnimationCreator