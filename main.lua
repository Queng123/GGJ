
function love.load()
    require "parallax"
    parallax.load()
    love.window.setMode(1920, 1080)
end

function love.draw()
    parallax.draw()
end

function love.update(dt)
    parallax.update(dt)
end