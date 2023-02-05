Button = {}

font = love.graphics.newFont(30)

-- require "Button"
-- require "SoundButton"

-- local function closeAllButton()
--     resumeButton.active = false
--     optionButton.active = false
--     quitButton.active = false
--     musicSlider.active = false
-- end

-- local function doNothing()
-- end

-- local function closePause()
--     resumeButton.active = false
-- end

-- music = love.audio.newSource("audio.mp3", "stream")
-- love.audio.setVolume(1)
-- love.audio.play(music)

-- resumeButton = {
--     pos = {x = 300, y = 100},
--     size = {x = 200, y = 100},
--     stringText = "Resume",
--     text = love.graphics.newText(font, "Resume"),
--     active = true,
--     action = closePause,
--     type = ButtonType.Classic,
--     isPressed = false,
--     update = doNothing
-- }

-- optionButton = {
--     pos = {x = 300, y = 250},
--     size = {x = 200, y = 100},
--     stringText = "Option",
--     text = love.graphics.newText(font, "Option"),
--     active = true,
--     action = closeAllButton,
--     type = ButtonType.Classic,
--     isPressed = false,
--     update = doNothing
-- }

-- local function getReferenceMusicSlider()
--     return love.audio.getVolume(music)
-- end

-- local function updateMusicSlider(button, x, y)
--     local newVolume = (x - button.pos.x) / button.size.x
--     print(newVolume)
--     if newVolume < 0 then
--         newVolume = 0
--     elseif newVolume > 1 then
--         newVolume = 1
--     end
--     love.audio.setVolume(newVolume)
-- end

-- musicSlider = {
--     pos = {x = 280, y = 300},
--     size = {x = 240, y = 20},
--     stringText = "Music",
--     text = love.graphics.newText(font, "Music"),
--     active = true,
--     action = doNothing,
--     type = ButtonType.Slider,
--     reference = getReferenceMusicSlider,
--     isPressed = false,
--     update = updateMusicSlider
-- }

-- quitButton = {
--     pos = {x = 300, y = 400},
--     size = {x = 200, y = 100},
--     stringText = "Quit",
--     text = love.graphics.newText(font, "Quit"),
--     active = true,
--     action = closeAllButton,
--     type = ButtonType.Classic,
--     isPressed = false,
--     update = doNothing
-- }

-- function love.draw()
--     Button.draw(resumeButton)
--     -- Button.draw(optionButton)
--     Button.draw(quitButton)
--     Button.draw(musicSlider)
-- end

-- function love.mousepressed(x, y, btn, istouch)
--     Button.mousepressed(resumeButton, x, y, btn, istouch)
--     -- Button.mousepressed(optionButton, x, y, btn, istouch)
--     Button.mousepressed(quitButton, x, y, btn, istouch)
--     Button.mousepressed(musicSlider, x, y, btn, istouch)
-- end

-- function love.mousereleased(x, y, button)
--     Button.mousereleased(musicSlider, x, y, button)
-- end

-- function love.mousemoved(x, y, dx, dy)
--     Button.mousemoved(musicSlider, x, y, dx, dy)
-- end


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
