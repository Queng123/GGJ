parallaxe = {}

function obstacles.load()
    s_dirt = love.graphics.newImage("assets/dirt.png")
end

function obstacles.update()

end

function obstacles.draw()
    love.graphics.draw(s_dirt, 0, 0)
end