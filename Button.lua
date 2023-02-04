Button = {}

-- local function closeAllButton()
--     resumeButton.active = false
--     optionButton.active = false
--     quitButton.active = false
-- end

-- local function closePause()
--     resumeButton.active = false
-- end

-- resumeButton = {
--     pos = {x = 300, y = 100},
--     size = {x = 200, y = 100},
--     stringText = "Resume",
--     text = love.graphics.newText(font, "Resume"),
--     active = true,
--     action = closePause
-- }

-- optionButton = {
--     pos = {x = 300, y = 250},
--     size = {x = 200, y = 100},
--     stringText = "Option",
--     text = love.graphics.newText(font, "Option"),
--     active = true,
--     action = closeAllButton
-- }

-- quitButton = {
--     pos = {x = 300, y = 400},
--     size = {x = 200, y = 100},
--     stringText = "Quit",
--     text = love.graphics.newText(font, "Quit"),
--     active = true,
--     action = closeAllButton
-- }

-- function love.draw()
--     Button.draw(resumeButton)
--     Button.draw(optionButton)
--     Button.draw(quitButton)
-- end

-- function love.mousepressed(x, y, btn, istouch)
--     Button.mousepressed(resumeButton, x, y, btn, istouch)
--     Button.mousepressed(optionButton, x, y, btn, istouch)
--     Button.mousepressed(quitButton, x, y, btn, istouch)
-- end

font = love.graphics.newFont(30)

function Button.draw(button)
    if (button.active) then
        love.graphics.push()
        love.graphics.setColor(1, 1, 1)
        love.graphics.translate(button.pos.x, button.pos.y)
        love.graphics.rectangle("fill", 0, 0, button.size.x, button.size.y)

        love.graphics.setColor(0, 0, 0)
        love.graphics.draw(button.text, button.size.x / 2 - button.text:getWidth() / 2 , button.size.y / 2 - button.text:getHeight() / 2)
        love.graphics.pop()
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
            print("button", button.stringText, "is pressed")
            if button.active then
                button.action()
            end
        else
            print("No button pressed")
        end
    end
end
