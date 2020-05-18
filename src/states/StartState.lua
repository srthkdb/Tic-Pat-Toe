StartState = Class { __includes = BaseState }

local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds[O]:play()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds[X]:play()

        if highlighted == 1 then
            gStateMachine:change('player')
        else
            gStateMachine:change('play', { ['AI'] = nil })
        end
    end
end

function StartState:render()
    --title
    love.graphics.setFont(gFonts['title'])
    love.graphics.printf('Tic Pat Toe', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['franzi'])

    if highlighted == 1 then
        love.graphics.setColor(103, 255, 0, 255)
    end

    love.graphics.printf('1 Player', 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255, 255, 255, 255)

    if highlighted == 2 then
        love.graphics.setColor(103, 255, 0, 255)
    end

    love.graphics.printf('2 Player', 0, VIRTUAL_HEIGHT / 2 + 200, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(103, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Use arrow keys to navigate and enter to select', 0, VIRTUAL_HEIGHT - 80, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Pat escape to exit', 0, VIRTUAL_HEIGHT - 40, VIRTUAL_WIDTH, 'center')
end
