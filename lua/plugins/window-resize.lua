-- window resize mode plugin!
-- this is a standalone local plugin that doesn't need lazy.nvim loading, but i'm keeping it in the plugins folder anyways

local resize_mode = false

local function enter_resize_mode()
    resize_mode = true
    print("-- RESIZE MODE -- (h/j/k/l to resize, <Esc>/jk/kj to exit)")

    vim.keymap.set('n', 'h', function()
        if resize_mode then
            local current_win = vim.fn.winnr()
            local leftmost_win = vim.fn.winnr('1h')

            if leftmost_win == current_win then
                -- This is the leftmost window, shrink it
                vim.cmd('vertical resize -2')
            else
                -- There's a window to the left, grow this window
                vim.cmd('vertical resize +2')
            end
        end
    end, { noremap = true, silent = true })

    vim.keymap.set('n', 'l', function()
        if resize_mode then
            local current_win = vim.fn.winnr()
            local leftmost_win = vim.fn.winnr('1h')

            if leftmost_win == current_win then
                -- This is the leftmost window, grow it
                vim.cmd('vertical resize +2')
            else
                -- There's a window to the left, shrink this window
                vim.cmd('vertical resize -2')
            end
        end
    end, { noremap = true, silent = true })

    vim.keymap.set('n', 'k', function()
        if resize_mode then
            local current_win = vim.fn.winnr()
            local topmost_win = vim.fn.winnr('1k')

            if topmost_win == current_win then
                -- This is the topmost window, shrink it
                vim.cmd('resize -2')
            else
                -- There's a window above, grow this window
                vim.cmd('resize +2')
            end
        end
    end, { noremap = true, silent = true })

    vim.keymap.set('n', 'j', function()
        if resize_mode then
            local current_win = vim.fn.winnr()
            local topmost_win = vim.fn.winnr('1k')

            if topmost_win == current_win then
                -- This is the topmost window, grow it
                vim.cmd('resize +2')
            else
                -- There's a window above, shrink this window
                vim.cmd('resize -2')
            end
        end
    end, { noremap = true, silent = true })

    local function exit_resize_mode()
        if resize_mode then
            resize_mode = false
            print("")
            -- Remove the temporary mappings
            vim.keymap.del('n', 'h')
            vim.keymap.del('n', 'l')
            vim.keymap.del('n', 'k')
            vim.keymap.del('n', 'j')
            vim.keymap.del('n', '<Esc>')
            vim.keymap.del('n', 'jk')
            vim.keymap.del('n', 'kj')
        end
    end

    vim.keymap.set('n', '<Esc>', exit_resize_mode, { noremap = true, silent = true })
    vim.keymap.set('n', 'jk', exit_resize_mode, { noremap = true, silent = true })
    vim.keymap.set('n', 'kj', exit_resize_mode, { noremap = true, silent = true })
end

_G.enter_resize_mode = enter_resize_mode

-- return empty table since we don't need lazy.nvim to manage it
return {}
