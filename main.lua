require "src/shovel"
require "src/parallaxe"
require "src/obstacles"
require "src/Button"
require "src/root"
require "src/Collision"
require "src/Gameover"
require "src/highScore"

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
    love.graphics.setBackgroundColor(124 / 255, 73 / 255, 39 / 255)
    Gameover.load()

    readyToQuit = false
    gaming = false
    lose = false

    gamemode = gamemodeType.endless

    speed = 200

    parallaxe.load()
    shovel.load()
    obstacles.load()
    root.load()
    Button.load()
    highScore.load()
end

function love.update(dt)
    if gaming then
        parallaxe.update(dt, speed)
        shovel.update(dt, speed)
        obstacles.update(dt, speed)
        root.update(dt, speed)
        Collision.checkCollision()
        speed = 200 + 10 * score
    elseif lose then
        for i, point in ipairs(points) do
            table.remove(points, i)
        end
        for i, water in ipairs(waters) do
            table.remove(waters, i)
        end
        for i, rock in ipairs(rocks) do
            table.remove(rocks, i)
        end
    end
end

function love.draw()
    if gaming then
        parallaxe.draw()
        obstacles.draw()
        shovel.draw()
        root.draw()
        love.graphics.printf(score, 50, 50, 150)
    elseif lose then
        Gameover.draw()
        Button.draw(gameOverMenuButton)
    else
        parallaxe.draw()
        obstacles.draw()
        shovel.draw()
        root.draw()
        Button.draw(playEndlessButton)
        Button.draw(playSongButton)
        Button.draw(quitButton)
        Button.draw(musicSlider)
        love.graphics.printf("High Score: ", 50, 700, 700)
        love.graphics.printf(highScore[1] , 50, 750, 700)
        love.graphics.printf(highScore[2] , 50, 800, 700)
        love.graphics.printf(highScore[3] , 50, 850, 700)
        love.graphics.printf("GitHub Crédits :", 1600, 600, 700)
        love.graphics.printf("Queng123" , 1600, 650, 700)
        love.graphics.printf("Miou-zora" , 1600, 700, 700)
        love.graphics.printf("Kibatsu03" , 1600, 750, 700)
        love.graphics.printf("FoxaxeWasTaken" , 1600, 800, 700)
        love.graphics.printf("kimmaroe" , 1600, 850, 700)
    end
end

function love.mousepressed(x, y, btn, istouch)
    Button.mousepressed(playEndlessButton, x, y, btn, istouch)
    Button.mousepressed(playSongButton, x, y, btn, istouch)
    Button.mousepressed(musicSlider, x, y, btn, istouch)
    Button.mousepressed(quitButton, x, y, btn, istouch)
    Button.mousepressed(gameOverMenuButton, x, y, btn, istouch)
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
