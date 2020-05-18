PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.currPlayer = X
    self.board = Board()
    self.highlighted = {i = 2, j = 2}
    self.AI = params['AI']
end

function PlayState:move()
    if love.keyboard.wasPressed('up') then
        self.highlighted.i = math.max(1, self.highlighted.i - 1)
    elseif love.keyboard.wasPressed('down') then
        self.highlighted.i = math.min(3, self.highlighted.i + 1)
    elseif love.keyboard.wasPressed('left') then
        self.highlighted.j = math.max(1, self.highlighted.j - 1)
    elseif love.keyboard.wasPressed('right') then
        self.highlighted.j = math.min(3, self.highlighted.j + 1)
    end    
end 

function PlayState:makeMove(act)
    self.board = result(self.board, act)
    -- gSounds[self.currPlayer]:play()
    if terminal(self.board) then
        gStateMachine:change('game-over', {['winner'] = winner(self.board)})
    end
    self.currPlayer = player(self.board)
end

function PlayState:update(dt)
    self:move()

    if self.currPlayer == self.AI then
        self:makeMove(minimax(self.board))
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self:makeMove({i = self.highlighted.i, j = self.highlighted.j})
    end
end

function PlayState:render()
    for i = 1, 3 do 
        for j = 1, 3 do 
            love.graphics.rectangle('fill', OFFSET + (j - 1) * (BOX_SIZE + GAP), OFFSET + (i - 1) * (BOX_SIZE + GAP), BOX_SIZE, BOX_SIZE)
        end
    end

    for i = 1, 3 do 
        for j = 1, 3 do 
            love.graphics.draw(gTextures[self.board.board[i][j]], OFFSET + (j - 1) * (BOX_SIZE + GAP) + IMG_OFFSET[self.board.board[i][j]], OFFSET + (i - 1) * (BOX_SIZE + GAP))
        end
    end
    love.graphics.setColor(0.6, 0.2, 0.6, 1)
    love.graphics.setLineWidth(10)
    love.graphics.rectangle('line', OFFSET + (self.highlighted.j - 1) * (BOX_SIZE + GAP), OFFSET + (self.highlighted.i - 1) * (BOX_SIZE + GAP), BOX_SIZE, BOX_SIZE)
    love.graphics.setColor(1, 1, 1, 1)
end 