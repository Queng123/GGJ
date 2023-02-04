parallax = {}

function parallax.load()

    screen_height = love.graphics.getHeight()
    randomNumber = love.math.random(1, 9)
    sprite = love.graphics.newImage("assets/rock.png")
    x = love.graphics.getWidth()
    y = math.random(0, 500)
    speed = 200
end

function parallax.update(dt)
    x = x - speed * dt
end

function parallax.draw()
    love.graphics.draw(sprite, x, y)
end