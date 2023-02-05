obstacles = {}

function obstacles.load()
    screen_height = love.graphics.getHeight()
    s_rock1 = love.graphics.newImage("assets/stone3.png")
    s_rock2 = love.graphics.newImage("assets/stone2.png")
    s_water = love.graphics.newImage("assets/water.png")
    s_tree = love.graphics.newImage("assets/tree.png")
    rocks = {}
    waters = {}
    rock_timer = 0
    rock_spawn_interval = 1
    water_timer = 0
    water_spawn_interval = 3
    score = 0
    font = love.graphics.newFont(70)
end

function obstacles.update(dt, speeds)
    -- Rock
    rock_timer = rock_timer + dt
    rock_spawn_interval = love.math.random(30, 130) / 100
    if rock_timer >= rock_spawn_interval then
        rock_timer = rock_timer - rock_spawn_interval
        rock_x = love.graphics.getWidth()
        rock_y = love.math.random(320, screen_height - s_rock2:getHeight())
        rockRand = love.math.random(1, 2)
        table.insert(rocks, {x = rock_x, y = rock_y, speed = speeds, rand = rockRand})
    end
    for i, rock in ipairs(rocks) do
        rock.x = rock.x - rock.speed * dt
    end
    -- Water
    mouse_x, mouse_y = love.mouse.getPosition()
    water_timer = water_timer + dt
    water_spawn_interval = love.math.random(130, 230) / 100
    if water_timer >= water_spawn_interval then
        water_timer = water_timer - water_spawn_interval
        water_x = love.graphics.getWidth()
        water_y = love.math.random(320, screen_height - s_water:getHeight())
        table.insert(waters, {x = water_x, y = water_y, speed = speeds})
    end
    for i, water in ipairs(waters) do
        water.x = water.x - water.speed * dt
        -- Colision between mouse and water
        if mouse_x >= water.x and mouse_x <= water.x + 32 and
        mouse_y >= water.y and mouse_y <= water.y + 32 then
            table.remove(waters, i)
            score = score + 1
        end
    end
end

function obstacles.draw()
    for i, rock in ipairs(rocks) do
        if rock.rand == 1 then
            love.graphics.draw(s_rock1, rock.x, rock.y, 0, 1.2, 1.2)
        else
            love.graphics.draw(s_rock2, rock.x, rock.y, 0, 1, 1)
        end
    end
    for i, water in ipairs(waters) do
        love.graphics.draw(s_water, water.x, water.y, 0, 1, 1)
    end
    love.graphics.setFont(font)
    love.graphics.draw(s_tree, -300, -750, 0, 3, 3)
end