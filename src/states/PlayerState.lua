PlayerState = Class { __includes = BaseState }

local highlighted = 1

function PlayerState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds[O]:play()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds[X]:play()

        if highlighted == 1 then
            gStateMachine:change('play', { ['AI'] = O })
        else
            gStateMachine:change('play', { ['AI'] = X })
        end
    end
end

function PlayerState:render()
    --title
    love.graphics.setFont(gFonts['fuzzy'])
    love.graphics.printf('Choose your favourite pet!', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['fuzzy'])

    if highlighted == 1 then
        love.graphics.setColor(103, 255, 0, 255)
    end

    love.graphics.printf('Dog', 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255, 255, 255, 255)

    if highlighted == 2 then
        love.graphics.setColor(103, 255, 0, 255)
    end

    love.graphics.printf('Cat', 0, VIRTUAL_HEIGHT / 2 + 200, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(103, 255, 255, 255)

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Good boi goes first!', 0, VIRTUAL_HEIGHT - 60, VIRTUAL_WIDTH, 'center')
end
