-- Import libraries:
local Object = require("libs.classic")
local Color = require("libs.usefulScripts.hex2color")
local CheckCollision = require("libs.usefulScripts.boundingbox")
----------------------------------------------------------------

local Button = Object:extend()

function Button:new(x, y, text, callback, backgroundColor, hoveredColor, textColor, margin)
    self.text = text or "Button"
    self.margin = margin or 5
    self.font = _G.ASSETS.fonts.ui
    self.hovered = false

    -- Set button size and position.
    self.x = x or 32
    self.y = y or 32
    self.w = self.font:getWidth(self.text) + self.margin*2
    self.h = self.font:getHeight() + self.margin*2

    -- Set button appereance.
    local colors = _G.COLORS
    self.backgroundColor = Color(backgroundColor or colors.darkGrey)
    self.hoveredColor = Color(hoveredColor or colors.lightGrey) 
    self.textColor = Color(textColor or colors.black)

    -- Set button callback.
    local function defaultCallback()
        print("Button without assigned callback function...")
    end
    self.callback = callback or defaultCallback
end

function Button:update(dt)
    -- Checks if mouse is above the button.
    local mouseX, mouseY = love.mouse.getPosition()
    self.hovered = CheckCollision(mouseX, mouseY, 1, 1, self.x, self.y, self.w, self.h)

    if (self.hovered) then
        love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
    end
end

function Button:draw()
    love.graphics.push("all")

    -- Draw button
    local buttonColor = self.hovered and self.hoveredColor or self.backgroundColor
    love.graphics.setColor(buttonColor)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

    -- Draw text
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    love.graphics.print(self.text, self.x + self.margin, self.y + self.margin)

    love.graphics.pop()
end

function Button:mousepressed(x, y, button, isTouch, presses)
    -- Execute button callback.
    if (self.hovered and button == 1) then
        self.callback()
    end
end

function Button:setColor(backgroundColor, hoveredColor, textColor)
    -- Set button appereance.
    local colors = _G.COLORS
    self.backgroundColor = Color(backgroundColor or colors.darkGrey)
    self.hoveredColor = Color(hoveredColor or colors.lightGrey) 
    self.textColor = Color(textColor or colors.black)
end

return Button