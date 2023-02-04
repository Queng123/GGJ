parallaxe = {}

local background = love.graphics.newImage("assets/grass.png")
local dirt = love.graphics.newImage("assets/dirt.png")
local cloud = love.graphics.newImage("assets/cloud.png")

function parallaxe.load()
    background_scroll = 0
    cloud_scroll = 0
end

function parallaxe.update(dt, speed)
    background_scroll = background_scroll - speed * dt
    if background_scroll <= -background:getWidth() then
        background_scroll = 0
    end
    cloud_scroll = cloud_scroll - speed / 2 * dt
    if cloud_scroll <= -background:getWidth() then
        cloud_scroll = 0
    end
end

function parallaxe.draw()
    love.graphics.draw(dirt, 0, 0)
    love.graphics.draw(background, background_scroll, 0)
    love.graphics.draw(background, background_scroll + background:getWidth(), 0)
    love.graphics.draw(cloud, cloud_scroll, -100, 0, 0.2, 0.2)
    love.graphics.draw(cloud, cloud_scroll + cloud:getWidth(), -100, 0, 0.2, 0.2)
end