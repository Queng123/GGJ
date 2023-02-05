require "shovel"
require "parallaxe"
require "obstacles"
require "Button"
require "root"

music = love.audio.newSource("audio.mp3", "stream")
love.audio.setVolume(1)
love.audio.play(music)

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("Game")

    readyToQuit = false
    gaming = false

    speed = 200

    parallaxe.load()
    shovel.load()
    obstacles.load()
    root.load()
    Button.load()
end

function love.update(dt)
    if gaming then
        parallaxe.update(dt, speed)
        shovel.update(dt, speed)
        obstacles.update(dt)
        root.update(dt, speed)
    end
end

function love.draw()
    if gaming then
        parallaxe.draw()
        obstacles.draw()
        shovel.draw()
        root.draw()
        love.graphics.printf(score, 50, 50, 150)
    else
        Button.draw(resumeButton)
        Button.draw(quitButton)
        Button.draw(musicSlider)
    end
end

function love.mousepressed(x, y, btn, istouch)
    Button.mousepressed(resumeButton, x, y, btn, istouch)
    Button.mousepressed(musicSlider, x, y, btn, istouch)
    Button.mousepressed(quitButton, x, y, btn, istouch)
end

function love.mousereleased(x, y, button)
    Button.mousereleased(musicSlider, x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    Button.mousemoved(musicSlider, x, y, dx, dy)
end

function love.keypressed(key)
    Button.keypressed(key)
end
