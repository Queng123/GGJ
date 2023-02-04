function love.load()
    love.window.setMode(1920, 1080)
    s_dirt = love.graphics.newImage("assets/dirt.png")
    s_grass = love.graphics.newImage("assets/grass.png")
end

function love.update()

end

function love.draw(dt)
    love.graphics.draw(s_dirt, 0, 0)
    love.graphics.draw(s_grass, 0, 0)
end
