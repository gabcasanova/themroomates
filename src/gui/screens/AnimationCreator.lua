-- Import libraries:
local Object = require("libs.classic")

-- Import GUI Elements:
local Button = require("src.gui.Button")
--------------------------------------

local AnimationCreator = Object:extend()

function AnimationCreator:new()
    self.buttons = {
        testButton = Button()
    }
end

function AnimationCreator:update(dt)
    for index, button in pairs(self.buttons) do
        button:update(dt)
    end
end

function AnimationCreator:draw()
    for index, button in pairs(self.buttons) do
        button:draw()
    end
end

function AnimationCreator:mousepressed(x, y, _button, isTouch, presses)
    for index, button in pairs(self.buttons) do
        button:mousepressed(x, y, _button, isTouch, presses)
    end
end

return AnimationCreator