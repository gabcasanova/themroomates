-- Import libraries:
local Object = require("libs.classic")
local g3d = require("libs.g3d")
local flux = require("libs.flux")
--------------------------------------

local Player = Object:extend()

function Player:new(x, y, z)
    -- Creates 3D models for each body part with it's own
    -- transformation attributes (translation, rotation and scale).
    -- The texture and model files follow a specific naming 
    -- convention: [name of the skin] + "_" + [body part name]
    local function createBodyModels(path, modelName)
        local models = {
            head = {
                model = path.heads .. modelName .. "_Head.obj",
                texture = path.heads .. modelName .. "_Head.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, 1}
                }
            },
            body = {
                model = path.bodies .. modelName .. "_Body.obj",
                texture = path.bodies .. modelName .. "_Body.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, 1}
                }
            },
            armTopRight = {
                model = path.arms .. modelName .. "_ArmTop.obj",
                texture = path.arms .. modelName .. "_Arm.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, 1}
                }
            },
            armBottomRight = {
                model = path.arms .. modelName .. "_ArmBottom.obj",
                texture = path.arms .. modelName .. "_Arm.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, 1}
                }
            },
            armTopLeft = {
                model = path.arms .. modelName .. "_ArmTop.obj",
                texture = path.arms .. modelName .. "_Arm.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, -1}
                }
            },
            armBottomLeft = {
                model = path.arms .. modelName .. "_ArmBottom.obj",
                texture = path.arms .. modelName .. "_Arm.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, -1}
                }
            },
            legTopRight = {
                model = path.legs .. modelName .. "_LegTop.obj",
                texture = path.legs .. modelName .. "_Leg.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, -1}
                }
            },
            legBottomRight = {
                model = path.legs .. modelName .. "_LegBottom.obj",
                texture = path.legs .. modelName .. "_Leg.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, -1}
                }
            },
            legTopLeft = {
                model = path.legs .. modelName .. "_LegTop.obj",
                texture = path.legs .. modelName .. "_Leg.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, 1}
                }
            },
            legBottomLeft = {
                model = path.legs .. modelName .. "_LegBottom.obj",
                texture = path.legs .. modelName .. "_Leg.png",
                transform = {
                    translation = {0, 0, 0},
                    rotation = {1.5, 0, 0},
                    scale = {1, 1, 1}
                }
            }
        }

        -- Creates 3D objects for each model part.
        for index, modelPart in pairs(models) do
            local currentPart = models[index]

            models[index].model3d = g3d.newModel(
                currentPart.model, 
                currentPart.texture, 
                currentPart.transform.translation,
                currentPart.transform.rotation,
                currentPart.transform.scale
            )
        end

        return models
    end
    self.models = createBodyModels(_G.GAME_PATHS.playerModels, "guy")

    -- Creates animations. Each animation has several 
    -- "frame" tables with transformation information 
    -- for each body part.
    local function createAnimations()
        return {
            currentAnimation = "walking",
            currentAnimationFrame = 2,
            currentTimer = 0,
            maxTimer = 0.7,

            walking = {
                { -- Frame 1
                    head = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    body = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armTopRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armBottomRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armTopLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    armBottomLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legTopRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legBottomRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legTopLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    legBottomLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    }
                },
                { -- Frame 2
                    head = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1.5, 1.5, 1.5}
                    },
                    body = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armTopRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armBottomRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armTopLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    armBottomLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legTopRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legBottomRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legTopLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    legBottomLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    }
                },
                { -- Frame 3
                    head = {
                        translation = {-0.5, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1.5, 1.5, 1.5}
                    },
                    body = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armTopRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armBottomRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    armTopLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    armBottomLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legTopRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legBottomRight = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, -1}
                    },
                    legTopLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    },
                    legBottomLeft = {
                        translation = {0, 0, 0},
                        rotation = {1.5, 0, 0},
                        scale = {1, 1, 1}
                    }
                }
            }
        }
    end
    self.animations = createAnimations()
end

function Player:update(dt)
    local currentAnimation = self.animations.currentAnimation
    local currentFrame = self.animations.currentAnimationFrame
    local maxTimer = self.animations.maxTimer

    -- Update each body model part's transformation based
    -- on the current animation frame's transformation.
    for index, animation in pairs(self.animations) do
        if (currentAnimation == index) then
            for key, modelPart in pairs(self.models) do
                local currentAnimationFrame = self.animations[currentAnimation][currentFrame][key]
                local tweenVel = maxTimer - 0.5

                --modelPart.transform = currentAnimationFrame
                flux.to(modelPart.transform.rotation, tweenVel, currentAnimationFrame.rotation)
                flux.to(modelPart.transform.scale, tweenVel, currentAnimationFrame.scale)
                flux.to(modelPart.transform.translation, tweenVel, currentAnimationFrame.translation)
            end
        end
    end

    -- Update animations timer, if the timer hasn't reached 
    -- it's max limit. If not, update the current animation frame,
    -- if the animation hasn't reached it's final frame yet.
    self.animations.currentTimer = self.animations.currentTimer + dt
    if (self.animations.currentTimer > maxTimer) then
        self.animations.currentTimer = 0

        if (self.animations.currentAnimationFrame < #self.animations[currentAnimation]) then
            self.animations.currentAnimationFrame = self.animations.currentAnimationFrame + 1 
        else
            self.animations.currentAnimationFrame = 1
        end
    end

    flux.update(dt) -- Update tweening library.
end

function Player:draw()
    -- Goes through every single body part model
    -- and draws the specific body part, based on
    -- it's own transformation attributes.
    for key, modelPart in pairs(self.models) do
        modelPart.model3d:draw()

        modelPart.model3d:setTransform(
            modelPart.transform.translation,
            modelPart.transform.rotation,
            modelPart.transform.scale
        )
    end
end

return Player