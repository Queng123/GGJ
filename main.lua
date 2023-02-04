require "shovel"
require "parallaxe"


function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Game")

    speed = 200

    parallaxe.load()
    shovel.load()
end

function love.update(dt)
    parallaxe.update(dt, speed)
    shovel.update(dt, speed)
end

function love.draw()
    parallaxe.draw()
    shovel.draw()
end
