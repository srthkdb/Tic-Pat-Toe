require 'src/dependencies'

function love.load()
    love.window.setTitle('Tic-Pat-Toe')
    math.randomseed(os.time())
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gFonts = {
        ['game-over'] = love.graphics.newFont('fonts/font.ttf', 250),
        ['title'] = love.graphics.newFont('fonts/goodBoy.ttf', 200),
        ['title_small'] = love.graphics.newFont('fonts/goodBoy.ttf', 100),
        ['fuzzy'] = love.graphics.newFont('fonts/fuzzy.ttf', 100),
        ['franzi'] = love.graphics.newFont('fonts/Franzi.ttf', 100),
        ['small'] = love.graphics.newFont('fonts/fuzzy.ttf', 40),
    }

    gSounds = {
        ['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
        [X] = love.audio.newSource('sounds/bark.mp3', 'static'),
        [O] = love.audio.newSource('sounds/meow.mp3', 'static'),
    }

    gTextures = {
        ['background'] = love.graphics.newImage('graphics/dog_cat_bg.jpg'),
        [X] = love.graphics.newImage('graphics/dog.png'),
        [O] = love.graphics.newImage('graphics/cat.png'),
        [EMPTY] = love.graphics.newImage('graphics/empty.png'),
    }

    gStateMachine = StateMachine({
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end,
        ['player'] = function() return PlayerState() end,
    })

    gStateMachine:change('start')

    gSounds['music']:setLooping(true)
    gSounds['music']:play()
    
    love.keyboard.keysPressed = {}
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    end
    return false
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], 0, 0,
        0,
        VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))


    gStateMachine:render()
    push:finish()
end