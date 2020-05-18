Board = Class{}

function Board:init()
    self:setupBoard()
end

function Board:setupBoard()
    self.board = {}

    for i = 1, 3 do
        local row = {}

        for j = 1, 3 do
            row[#row + 1] = EMPTY
        end

        self.board[#self.board + 1] = row
    end
end

function Board:copyBoard(board)
    for i = 1, 3 do
        for j = 1, 3 do
            self.board[i][j] = board.board[i][j]
        end
    end
end