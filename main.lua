require "shovel"
require "parallaxe"
require "obstacles"
require "Button"

local function closeAllButton()
    resumeButton.active = false
    quitButton.active = false
    musicSlider.active = false
end

local function openAllButton()
    resumeButton.active = true
    quitButton.active = true
    musicSlider.active = true
end

local function doNothing()
end

local function closePause()
    closeAllButton()
    gaming = true
end

music = love.audio.newSource("audio.mp3", "stream")
love.audio.setVolume(1)
love.audio.play(music)

resumeButton = {
    pos = {x = 1920 / 2 - 100, y = 400},
    size = {x = 200, y = 100},
    stringText = "Play",
    text = love.graphics.newText(font, "Resume"),
    active = true,
    action = closePause,
    type = ButtonType.Classic,
    isPressed = false,
    update = doNothing
}

optionButton = {
    pos = {x = 300, y = 250},
    size = {x = 200, y = 100},
    stringText = "Option",
    text = love.graphics.newText(font, "Option"),
    active = true,
    action = closeAllButton,
    type = ButtonType.Classic,
    isPressed = false,
    update = doNothing
}

local function getReferenceMusicSlider()
    return love.audio.getVolume(music)
end

local function updateMusicSlider(button, x, y)
    local newVolume = (x - button.pos.x) / button.size.x
    print(newVolume)
    if newVolume < 0 then
        newVolume = 0
    elseif newVolume > 1 then
        newVolume = 1
    end
    love.audio.setVolume(newVolume)
end

musicSlider = {
    pos = {x = 1920 / 2 - 120, y = 600},
    size = {x = 240, y = 20},
    stringText = "Music",
    text = love.graphics.newText(font, "Music"),
    active = true,
    action = doNothing,
    type = ButtonType.Slider,
    reference = getReferenceMusicSlider,
    isPressed = false,
    update = updateMusicSlider
}

local function closeGame()
    love.event.quit()
end

quitButton = {
    pos = {x = 1920 / 2 - 100, y = 700},
    size = {x = 200, y = 100},
    stringText = "Quit",
    text = love.graphics.newText(font, "Quit"),
    active = true,
    action = closeGame,
    type = ButtonType.Classic,
    isPressed = false,
    update = doNothing
}

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Game")

    readyToQuit = false
    gaming = false

    speed = 200

    parallaxe.load()
    shovel.load()
    obstacles.load()
end

function love.update(dt)
    if gaming then
        parallaxe.update(dt, speed)
        shovel.update(dt, speed)
        obstacles.update(dt)
    end
end

function love.draw()
    if gaming then
        parallaxe.draw()
        obstacles.draw()
        shovel.draw()
    else
        Button.draw(resumeButton)
        Button.draw(quitButton)
        Button.draw(musicSlider)
    end
end

function love.mousepressed(x, y, btn, istouch)
    Button.mousepressed(resumeButton, x, y, btn, istouch)
    Button.mousepressed(quitButton, x, y, btn, istouch)
    Button.mousepressed(musicSlider, x, y, btn, istouch)
end

function love.mousereleased(x, y, button)
    Button.mousereleased(musicSlider, x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    Button.mousemoved(musicSlider, x, y, dx, dy)
end

function love.keypressed(key)
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
