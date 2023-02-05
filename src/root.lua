root = {}
points = {}

function root.load()
    points[1] = {x = 850, y = 560}
    love.graphics.setColor(0.6, 0.3, 0.1)
    love.graphics.setLineWidth(10)
end

function root.update(dt, speed)
    local mouseX, mouseY = love.mouse.getPosition()
    if mouseY < 350 then
        mouseY = 350
    end
    local lastPoint = points[#points]
    local nextX = lastPoint.x + (mouseX - lastPoint.x) * dt
    local nextY = lastPoint.y + (mouseY - lastPoint.y) * dt
    table.insert(points, {x = nextX, y = nextY})
    for i = 1, #points do
        points[i].x = points[i].x - speed * dt
    end
    if points[1].x > love.graphics.getWidth() then
        table.remove(points, 1)
    end
end

function root.updateSongMode(dt, speed)
    local mouseX, mouseY = love.mouse.getPosition()
    if mouseY < 350 then
        mouseY = 350
    end
    mouseX = 200
    local lastPoint = points[#points]
    local nextX = lastPoint.x + (mouseX - lastPoint.x)
    local nextY = lastPoint.y + (mouseY - lastPoint.y) * dt * 2
    table.insert(points, {x = nextX, y = nextY})
    for i = 1, #points do
        points[i].x = points[i].x - speed * dt
    end
    if points[1].x > love.graphics.getWidth() then
        table.remove(points, 1)
    end
end

function root.draw()
    love.graphics.setColor(60 / 256, 28 / 256, 3 / 256)
    love.graphics.setLineWidth(15)
    for i = 1, #points - 1 do
        love.graphics.line(points[i].x, points[i].y, points[i + 1].x, points[i + 1].y)
    end
    love.graphics.setColor(1, 1, 1)
end
