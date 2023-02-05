require "src/Button"
require "src/obstacles"
require "src/Collision"

Gameover = {}

function Gameover:load()
    Gameover.text = love.graphics.newText(love.graphics.newFont(100), "Game Over")
end

function Gameover:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(Gameover.text, 1920 / 2 - Gameover.text:getWidth() / 2, 100)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Score: " .. score, 0, 350, 1920, "center")
end
