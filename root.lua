root = {}
local points = {}

function root.load()
    points[1] = {x = 0, y = love.graphics.getHeight()}
    love.graphics.setColor(0.6, 0.3, 0.1)
    love.graphics.setLineWidth(10)
end

function root.update(dt, speed)
    local mouseX, mouseY = love.mouse.getPosition()
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

function root.draw()
    for i = 1, #points - 1 do
        love.graphics.line(points[i].x, points[i].y, points[i + 1].x, points[i + 1].y)
    end
end
