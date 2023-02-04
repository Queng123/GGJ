parallax = {}

local scale = 0.25

function parallax.load()
    spade = love.graphics.newImage("assets/pelle.png")
    caracter = love.graphics.newImage("assets/caracter.png")
    x = -255
    y = love.graphics.getHeight() - spade:getHeight() * scale - 800
    speed = 200
    isPassed = false
    isSpade = false
    isntSpade = false
    randomPoint = love.math.random(500, 1700)
end

function parallax.update(dt)
    x = x - speed * dt

    if x < -300 then -- pour que la pelle revienne a sa position de depart a droite de l'ecran
        x = love.graphics.getWidth() + spade:getWidth() * scale - 200
        y = love.graphics.getHeight() - spade:getHeight() * scale - 800
        isPassed = false -- savoir si la pelle est passé par le point de descente
        isSpade = false -- savoir si la pelle est en train de se baisser
        isntSpade = false -- savoir si la pelle est en train de se relever
        randomPoint = love.math.random(500, 1700) -- point de descente random

    elseif x < randomPoint and isPassed == false then -- pour que la pelle se baisse en fonction d'un point random (randomPoint)
        if love.math.random(3) ~= 1 then -- pour que la pelle se baisse suivant un random de 2/3
            isSpade = true
        else
            isPassed = true
        end
    end

    if x < randomPoint - 500 then -- pour que la pelle se releve 500px apres le point de descente
        isntSpade = true
    end

    if isSpade == true and isntSpade == false and y < love.graphics.getHeight() - spade:getHeight() * scale - 480 then -- pour que la pelle se baisse
        y = y + 500 * dt
    end
    if isntSpade == true and y > love.graphics.getHeight() - spade:getHeight() * scale - 800 then -- pour que la pelle se releve
        y = y - 500 * dt
    end

end

function parallax.draw()
    love.graphics.draw(spade, x, y, 0, scale, scale)
    love.graphics.draw(caracter, x - 550, love.graphics.getHeight() - spade:getHeight() * scale - 1000, 0, 2, 2)
end
