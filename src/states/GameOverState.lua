GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
end

function GameOverState:enter(params)
    self.winner = params.winner
end

function GameOverState:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['game-over'])
    if self.winner == nil then
        love.graphics.printf("Draw!", 0, VIRTUAL_HEIGHT / 2 - 180, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf("Winner!", 0, VIRTUAL_HEIGHT / 2 - 180, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(gTextures[self.winner], (VIRTUAL_WIDTH - BOX_SIZE) / 2, (VIRTUAL_HEIGHT - BOX_SIZE) / 2 + 200)
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Good game!', 0, VIRTUAL_HEIGHT - 80, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Pat enter to return to main menu', 0, VIRTUAL_HEIGHT - 40, VIRTUAL_WIDTH, 'center')
end

