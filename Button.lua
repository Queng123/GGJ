Button = {}

font = love.graphics.newFont(30)

local function DrawClassicButton(button)
    love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    love.graphics.translate(button.pos.x, button.pos.y)
    love.graphics.rectangle("fill", 0, 0, button.size.x, button.size.y)

    love.graphics.setColor(0, 0, 0)
    love.graphics.draw(button.text, button.size.x / 2 - button.text:getWidth() / 2 , button.size.y / 2 - button.text:getHeight() / 2)
    love.graphics.pop()
end

local function DrawSliderButton(button)
    local thickness = button.size.y / 10

    love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    love.graphics.translate(button.pos.x, button.pos.y)
    love.graphics.rectangle("fill", 0, button.size.y / 1.33 - thickness / 2, button.size.x, thickness)

    love.graphics.ellipse("fill", button.reference() * button.size.x, button.size.y / 1.33 - thickness / 2, button.size.y, button.size.y)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(button.text, button.size.x / 2 - button.text:getWidth() / 2 , - button.size.y * 2)
    love.graphics.pop()
end

ButtonType = {Classic = "Classic", Slider = "Slider"}
DrawButtonFunction = {Classic = DrawClassicButton, Slider = DrawSliderButton}

function Button.draw(button)
    if (button.active) then
        DrawButtonFunction[button.type](button)
    end
end

local function isCollide(pos, rect)
    if (pos.x > rect.x and pos.x < rect.x + rect.dx and
        pos.y > rect.y and pos.y < rect.y + rect.dy) then
        return (true)
    else
        return (false)
    end
end


function Button.mousepressed(button, x, y, btn, istouch)
    if btn == 1 then
        if (isCollide({x = x, y = y},
                      {x = button.pos.x,
                       y = button.pos.y,
                       dx = button.size.x,
                       dy = button.size.y})) then
            button.isPressed = true
            print(button.stringText, "is pressed")
            if button.active then
                button.action()
            end
        end
    end
end

function Button.mousereleased(button, x, y, btn)
    if btn == 1 then
        button.isPressed = false

        print(button.stringText, "is released")
    end
end

function Button.mousemoved(button, x, y, dx, dy)
    if (button.isPressed and button.type == ButtonType.Slider) then
        print(x,y)
        button.update(button, x, y)
    end
end
