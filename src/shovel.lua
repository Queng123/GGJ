shovel = {}

local scale = 0.25

function shovel.load()
    spade = love.graphics.newImage("assets/pelle.png")
    caracter = love.graphics.newImage("assets/caracter.png")
    x_shovel = -300
    y_shovel = love.graphics.getHeight() - spade:getHeight() * scale - 800
    isPassed = false
    isSpade = false
    isntSpade = false
    randomPoint = love.math.random(500, 1700)
end

function shovel.update(dt, speed)
    x_shovel = x_shovel - speed * dt

    if x_shovel < -300 then -- pour que la pelle revienne a sa position de depart a droite de l'ecran
        x_shovel = love.graphics.getWidth() + spade:getWidth() * scale + 400
        y_shovel = love.graphics.getHeight() - spade:getHeight() * scale - 800
        isPassed = false -- savoir si la pelle est passé par le point de descente
        isSpade = false -- savoir si la pelle est en train de se baisser
        isntSpade = false -- savoir si la pelle est en train de se relever
        randomPoint = love.math.random(500, 1700) -- point de descente random
    elseif x_shovel < randomPoint and isPassed == false then -- pour que la pelle se baisse en fonction d'un point random (randomPoint)
        if love.math.random(3) ~= 1 then -- pour que la pelle se baisse suivant un random de 2/3
            isSpade = true
        else
            isPassed = true
        end
    end

    if x_shovel < randomPoint - 500 then -- pour que la pelle se releve 500px_shovel apres le point de descente
        isntSpade = true
    end

    if isSpade == true and isntSpade == false and y_shovel < love.graphics.getHeight() - spade:getHeight() * scale - 480 then -- pour que la pelle se baisse
        y_shovel = y_shovel + 500 * dt
    end
    if isntSpade == true and y_shovel > love.graphics.getHeight() - spade:getHeight() * scale - 800 then -- pour que la pelle se releve
        y_shovel = y_shovel - 500 * dt
    end

end

function shovel.draw()
    love.graphics.draw(spade, x_shovel, y_shovel, 0, scale, scale)
    love.graphics.draw(caracter, x_shovel - 550, love.graphics.getHeight() - spade:getHeight() * scale - 1000, 0, 2, 2)
end
