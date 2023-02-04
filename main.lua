require "shovel"
require "parallaxe"
require "obstacles"


function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Game")

    speed = 200

    parallaxe.load()
    shovel.load()
    obstacles.load()
end

function love.update(dt)
    parallaxe.update(dt, speed)
    shovel.update(dt, speed)
    obstacles.update(dt)
end

function love.draw()
    parallaxe.draw()
    obstacles.draw()
    shovel.draw()
end
