Button = {}

local function closeAllButton()
    playEndlessButton.active = false
    playSongButton.active = false
    quitButton.active = false
    musicSlider.active = false
end

local function openAllButton()
    playEndlessButton.active = true
    playSongButton.active = true
    quitButton.active = true
    musicSlider.active = true
end

local function doNothing()
end

local function closePause()
    closeAllButton()
    gaming = true
end

local function getReferenceMusicSlider()
    return love.audio.getVolume(music)
end

local function updateMusicSlider(button, x, y)
    local newVolume = (x - button.pos.x) / button.size.x
    if newVolume < 0 then
        newVolume = 0
    elseif newVolume > 1 then
        newVolume = 1
    end
    love.audio.setVolume(newVolume)
end

local function closeGame()
    love.event.quit()
end

local function createClassicButton(pos, size, stringText, action)
    local button = {}
    button.pos = pos
    button.size = size
    button.stringText = stringText
    button.text = love.graphics.newText(font, stringText)
    button.active = true
    button.action = action
    button.type = ButtonType.Classic
    button.isPressed = false
    button.update = doNothing
    return button
end

local function createSliderButton(pos, size, stringText, reference, action, update)
    local button = {}
    button.pos = pos
    button.size = size
    button.stringText = stringText
    button.text = love.graphics.newText(font, stringText)
    button.active = true
    button.action = action
    button.type = ButtonType.Slider
    button.reference = reference
    button.isPressed = false
    button.update = update
    return button
end

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

local function playEndless()
    gaming = true
    gamemode = gamemodeType.Endless
    closeAllButton()
end

local function playSong()
    gaming = true
    if music then
        love.audio.stop(music)
        love.audio.play(music)
    end
    gamemode = gamemodeType.Song
    closeAllButton()
end

local function actionPlayEndless()
    closePause()
    playEndless()
end

local function actionPlaySong()
    closePause()
    playSong()
end

function Button.load()
    font = love.graphics.newFont(30)

    ButtonType = {Classic = "Classic", Slider = "Slider"}
    DrawButtonFunction = {Classic = DrawClassicButton, Slider = DrawSliderButton}

    playEndlessButton = createClassicButton({x = 1920 / 2 - 100, y = 200}, {x = 200, y = 100}, "Play Endless", actionPlayEndless)
    playSongButton = createClassicButton({x = 1920 / 2 - 100, y = 350}, {x = 200, y = 100}, "Play Song", actionPlaySong)
    musicSlider = createSliderButton({x = 1920 / 2 - 100, y = 550}, {x = 200, y = 20}, "Music", getReferenceMusicSlider, doNothing, updateMusicSlider)
    quitButton = createClassicButton({x = 1920 / 2 - 100, y = 650}, {x = 200, y = 100}, "Quit", closeGame)
end



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
            if button.active then
                button.action()
            end
        end
    end
end

function Button.mousereleased(button, x, y, btn)
    if btn == 1 then
        button.isPressed = false
    end
end

function Button.mousemoved(button, x, y, dx, dy)
    if (button.isPressed and button.type == ButtonType.Slider) then
        button.update(button, x, y)
    end
end

function Button.keypressed(key)
    if key == "escape" then
        if gaming then
            gaming = false
            openAllButton()
        else
            gaming = true
            closeAllButton()
        end
    end
end
