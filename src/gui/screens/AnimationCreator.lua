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
    self.cameraFPS = false
    local windowWidth, windowHeight = love.graphics.getDimensions()

    -- Create 3D GameObjects.
    self.background = g3d.newModel(
        "assets/models/sphere.obj", 
        "assets/textures/starfield.png", 
        {0,0,0}, nil, {500,500,500}
    )
    self.objects = {
        character = Character()
    }

    -- Set default camera position.
    function self.defaultCameraView()
        g3d.camera.lookInDirection(2.03, 0.05, 1.80, -3.2, -0.2)
    end
    self.defaultCameraView()

    -- Create GUI interface.
    self.gui = {
        button_enableFpsCamera = Button(10, 140, "First Person Camera", function () 
            self.cameraFPS = not self.cameraFPS 
        end)
    }

    for i = 1, 10, 1 do -- Create a button for each animation frame.
        self.gui["button_animation" .. i] = Button(
            10 + (i-1)*40, 
            windowHeight-40, 
            i, 
            function () 
                self.objects.character.animations.currentAnimationFrame = i
            end
        )
    end
end

function AnimationCreator:update(dt)
    -- Update GameObjects.
    for index, object in pairs(self.objects) do
        object:update(dt)
    end
    
    -- Update GUI.
    if (not self.cameraFPS) then 
        for index, guiELement in pairs(self.gui) do
            -- Update all GUI elements
            guiELement:update(dt)

            -- In the buttons related to the animation timeline,
            -- light up the one that's currently related to the
            -- current player animation frame.
            if (string.find(index, "button_animation")) then
                if ((self.objects.character.animations.currentAnimationFrame) == guiELement.text) then
                    guiELement:setColor("#FFFFFF", "#FFFFFF")
                else 
                    guiELement:setColor()
                end
            end
        end
    else
        g3d.camera.firstPersonMovement(dt)
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
    if (self.cameraFPS) then
        local camera = g3d.camera
        love.graphics.print(
            " -- CAMERA POSITION --" ..
            "\n X: " .. tostring(g3d.camera.position[1]):sub(1, 4) .. " - " ..
               "Y: " .. tostring(g3d.camera.position[2]):sub(1, 4) .. " - " ..
               "Z: " .. tostring(g3d.camera.position[3]):sub(1, 4) ..
            "\n Direction: " .. tostring(g3d.camera.fpsController.direction):sub(1, 4) .. " - " ..
               "Pitch: " .. tostring(g3d.camera.fpsController.pitch):sub(1, 4) ..
            "\n " ..
            "\n -- CONTROLS --" ..
            "\n WASD - Forwards, Backwards, Strafe Left and Right" ..
            "\n Space - Go Up; Shift - Go Down" ..
            "\n Press ''Q'' or click to leave first person mode. Press ''R'' to reset.",
            10, 10
        )
    end
end

function AnimationCreator:keypressed(key, scancode, isrepeat)
    if (key == "q") then
        self.cameraFPS = not self.cameraFPS
    end

    if (key == "r") then
        self.defaultCameraView()
    end
end

function AnimationCreator:mousemoved(x, y, dx, dy)
    if (self.cameraFPS) then 
        g3d.camera.firstPersonLook(dx,dy) 
    else
        love.mouse.setRelativeMode(false)
    end
end

function AnimationCreator:mousepressed(x, y, _button, isTouch, presses)
    -- Mouse GUI.
    for index, button in pairs(self.gui) do
        button:mousepressed(x, y, _button, isTouch, presses)
    end
end

return AnimationCreator