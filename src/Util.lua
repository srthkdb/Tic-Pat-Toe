function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function table.clone(org)
    return {table.unpack(org)}
end

function player(board)
    local cnt = {
        [X] = 0,
        [O] = 0,
        [EMPTY] = 0
    }

    for i = 1, 3 do
        for j= 1, 3 do
            cnt[board.board[i][j]] = cnt[board.board[i][j]] + 1
        end
    end

    if cnt[X] > cnt[O] then
        return O
    else
        return X
    end
end

function actions(board)
    local act = {}

    for i = 1, 3 do
        for j= 1, 3 do
            if board.board[i][j] == EMPTY then
                act[#act + 1] = {i = i, j = j}
            end
        end
    end

    return act
end

function result(board, action)
    local ans = Board()
    ans:copyBoard(board)

    -- if ans.board[action.i][action.j] ~= EMPTY then
    --     return nil
    -- end

    ans.board[action.i][action.j] = player(ans)
    return ans
end

function winner(board)
    for i = 1, 3 do
        if board.board[i][1] ~= EMPTY and board.board[i][1] == board.board[i][2] and board.board[i][3] == board.board[i][2] then
            return board.board[i][1]
        end
    end

    for j = 1, 3 do
        if board.board[1][j] ~= EMPTY and board.board[1][j] == board.board[2][j] and board.board[1][j] == board.board[3][j] then
            return board.board[1][j]
        end
    end

    if board.board[1][1] ~= EMPTY and board.board[1][1] == board.board[2][2] and board.board[1][1] == board.board[3][3] then
        return board.board[1][1]
    end

    if board.board[1][3] ~= EMPTY and board.board[1][3] == board.board[2][2] and board.board[1][3] == board.board[3][1] then
        return board.board[1][3]
    end

    return nil
end

function terminal(board)
    if winner(board) ~= nil then
        return true
    end

    for i = 1, 3 do
        for j = 1, 3 do
            if board.board[i][j] == EMPTY then
                return false
            end
        end
    end
    return true
end

function utility(board)
    local win = winner(board)
    if win == nil then
        return 0
    elseif win == X then
        return 1
    else
        return -1
    end
end

function max_value(board)
    if terminal(board) then
        return utility(board)
    end

    local v = -100
    local act = actions(board)

    for k, a in pairs(act) do
        v = math.max(v, min_value(result(board, a)))
    end
    return v
end

function min_value(board)
    if terminal(board) then
        return utility(board)
    end

    local v = 100
    local act = actions(board)

    for k, a in pairs(act) do
        v = math.min(v, max_value(result(board, a)))
    end

    return v
end

function minimax(board)
    if terminal(board) then
        return nil
    end

    local ans = nil
    local acts = actions(board)
    local curr = nil
    if player(board) == X then
        curr = -100
        for k, a in pairs(acts) do
            local temp = max_value(result(board, a))
            if temp > curr then
                ans = a
                curr = temp
            end
        end
    else
        curr = 100
        for k, a in pairs(acts) do
            local temp = min_value(result(board, a))
            if temp < curr then
                ans = a
                curr = temp
            end
        end
    end

    return ans
end