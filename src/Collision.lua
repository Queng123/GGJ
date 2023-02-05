require "src/obstacles"
require "src/shovel"
require "src/root"

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
        end
    end
    for i, point in ipairs(points) do
        if point.x >= x_shovel and point.x <= x_shovel + 145 and
        point.y >= y_shovel and point.y <= y_shovel + 710 then
            gaming = false
            lose = true
        end
    end
end
