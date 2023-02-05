require "src/shovel"
require "src/parallaxe"
require "src/obstacles"
require "src/Button"
require "src/root"
require "src/Collision"

music = love.audio.newSource("audio.mp3", "stream")
love.audio.setVolume(1)
love.audio.play(music)

gamemodeType = {
    endless = 0,
    song = 1
}

function love.load()
    love.window.setMode(1920, 1080)
    love.window.setTitle("We Löve Root!")

    readyToQuit = false
    gaming = false

    gamemode = gamemodeType.endless

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
        obstacles.update(dt, speed)
        root.update(dt, speed)
        Collision.checkCollision()
        speed = 200 + 10 * score
    end
end

function love.draw()
    parallaxe.draw()
    obstacles.draw()
    shovel.draw()
    root.draw()
    if gaming then
        love.graphics.printf(score, 50, 50, 150)
    else
        Button.draw(playEndlessButton)
        Button.draw(playSongButton)
        Button.draw(quitButton)
        Button.draw(musicSlider)
    end
end

function love.mousepressed(x, y, btn, istouch)
    Button.mousepressed(playEndlessButton, x, y, btn, istouch)
    Button.mousepressed(playSongButton, x, y, btn, istouch)
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
