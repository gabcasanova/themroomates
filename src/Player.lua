-- Import libraries:
local Object = require("libs.classic")
local g3d = require("libs.g3d")
--------------------------------------

local Player = Object:extend()

function Player:new(x, y)
    self.modelName = "guy"
    self.modelPaths = {
        head = {
            model = _G.GAME_PATHS.playerModels.heads .. self.modelName .. "_Head.obj",
            texture = _G.GAME_PATHS.playerModels.heads .. self.modelName .. "_Head.png"
        },
        body = {
            model = _G.GAME_PATHS.playerModels.bodies .. self.modelName .. "_Body.obj",
            texture = _G.GAME_PATHS.playerModels.bodies .. self.modelName .. "_Body.png",
        },
        leg = {
            top = _G.GAME_PATHS.playerModels.legs .. self.modelName .. "_LegTop.obj",
            bottom = _G.GAME_PATHS.playerModels.legs .. self.modelName .. "_LegBottom.obj",
            texture = _G.GAME_PATHS.playerModels.legs .. self.modelName .. "_Leg.png"
        },
        arm = {
            top = _G.GAME_PATHS.playerModels.arms .. self.modelName .. "_ArmTop.obj",
            bottom = _G.GAME_PATHS.playerModels.arms .. self.modelName .. "_ArmBottom.obj",
            texture = _G.GAME_PATHS.playerModels.arms .. self.modelName .. "_Arm.png"
        }
    }

    self.armLeftOffset = 0
    self.model = {
        head = g3d.newModel(
            self.modelPaths.head.model, self.modelPaths.head.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, 1}
        ),
        body = g3d.newModel(
            self.modelPaths.body.model, self.modelPaths.body.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, 1}
        ),
        armTopRight = g3d.newModel(
            self.modelPaths.arm.top, self.modelPaths.arm.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, 1}
        ),
        armBottomRight = g3d.newModel(
            self.modelPaths.arm.bottom, self.modelPaths.arm.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, 1}
        ),
        armTopLeft = g3d.newModel(
            self.modelPaths.arm.top, self.modelPaths.arm.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, -1}
        ),
        armBottomLeft = g3d.newModel(
            self.modelPaths.arm.bottom, self.modelPaths.arm.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, -1}
        ),
        legTopLeft = g3d.newModel(
            self.modelPaths.leg.top, self.modelPaths.leg.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, 1}
        ),
        legBottomLeft = g3d.newModel(
            self.modelPaths.leg.bottom, self.modelPaths.leg.texture, 
            {0,0,0}, {1.5,0,0}, {1, 1, 1}
        ),
        legTopRight = g3d.newModel(
            self.modelPaths.leg.top, self.modelPaths.leg.texture, 
            {0,-0.05,0}, {1.5,0,0}, {1, 1, -1}
        ),
        legBottomRight = g3d.newModel(
            self.modelPaths.leg.bottom, self.modelPaths.leg.texture, 
            {0,-0.05,0}, {1.5,0,0}, {1, 1, -1}
        )
    }
    self.angle = 0
end

function Player:draw()
    for key, modelPart in pairs(self.model) do
        modelPart:draw()
    end
end

return Player