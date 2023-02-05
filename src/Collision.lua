require "src/obstacles"
require "src/shovel"
require "src/root"
require "src/highScore"

Collision = {}

function Collision.checkCollision()
    for i, water in ipairs(waters) do
        if points[#points].x >= water.x and points[#points].x <= water.x + 32 and
        points[#points].y >= water.y and points[#points].y <= water.y + 32 then
            table.remove(waters, i)
            score = score + 1
        end
    end
    for i, rock in ipairs(rocks) do
        if points[#points].x >= rock.x and points[#points].x <= rock.x + 32 and
        points[#points].y >= rock.y and points[#points].y <= rock.y + 32 then
            gaming = false
            lose = true
            if (score > highScore[1]) then
                highScore = {score, highScore[1], highScore[2]}
            elseif (score > highScore[2]) then
                highScore = {highScore[1], score, highScore[2]}
            elseif (score > highScore[3]) then
                highScore = {highScore[1], highScore[2], score}
            end
            file_descriptor = io.open("save/score", "w")
            file_descriptor:write(highScore[1] .. " " .. highScore[2] .. " " .. highScore[3])
            file_descriptor:close()
        end
    end
    for i, point in ipairs(points) do
        if point.x >= x_shovel and point.x <= x_shovel + 145 and
        point.y >= y_shovel and point.y <= y_shovel + 710 then
            gaming = false
            lose = true
            if (score > highScore[1]) then
                highScore = {score, highScore[1], highScore[2]}
            elseif (score > highScore[2]) then
                highScore = {highScore[1], score, highScore[2]}
            elseif (score > highScore[3]) then
                highScore = {highScore[1], highScore[2], score}
            end
            file_descriptor = io.open("save/score", "w")
            file_descriptor:write(highScore[1] .. " " .. highScore[2] .. " " .. highScore[3])
            file_descriptor:close()
        end
    end
end
