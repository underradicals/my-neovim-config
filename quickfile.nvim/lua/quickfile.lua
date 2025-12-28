local M = {}

local function create_floating_window()
    local width = 50
    local height = 1

    -- Create buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'text')

    -- Calculate window position (centered)
    local ui = vim.api.nvim_list_uis()[1]
    local win_height = ui.height
    local win_width = ui.width

    local row = math.floor((win_height - height) / 2)
    local col = math.floor((win_width - width) / 2)

    -- Window options
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
        title = ' Quick File Creator ',
        title_pos = 'center'
    }

    -- Create window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Set placeholder text
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {'Enter File Path'})

    -- Enter insert mode and select all text
    vim.schedule(function()
        vim.cmd('startinsert')
        -- Select all text in visual mode, then go back to insert
        local keys = vim.api.nvim_replace_termcodes('<Esc>ggVG<C-g>', true, false, true)
        vim.api.nvim_feedkeys(keys, 'n', false)
    end)

    return buf, win
end

local function create_file_and_open(path)
    if path == '' or path == 'Enter File Path' then
        return
    end

    -- Expand path
    path = vim.fn.expand(path)

    -- Get directory and create it
    local dir = vim.fn.fnamemodify(path, ':h')
    if dir ~= '' and dir ~= '.' then
        vim.fn.mkdir(dir, 'p')
    end

    -- Open the file in a new buffer
    vim.cmd('edit ' .. vim.fn.fnameescape(path))
end

function M.open()
    local buf, win = create_floating_window()

    -- Set up keymaps for the floating window
    local opts = {
        noremap = true,
        silent = true,
        buffer = buf
    }

    -- Handle Enter key
    vim.keymap.set('i', '<CR>', function()
        local line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
        vim.api.nvim_win_close(win, true)
        create_file_and_open(line)
    end, opts)

    -- Handle Escape key
    vim.keymap.set({'n', 'i'}, '<Esc>', function()
        vim.api.nvim_win_close(win, true)
    end, opts)
end

function M.setup(opts)
    opts = opts or {}

    -- Create user command
    vim.api.nvim_create_user_command('QuickFile', function()
        M.open()
    end, {})

    -- Optional: Set up default keybinding
    if opts.keymap then
        vim.keymap.set('n', opts.keymap, M.open, {
            noremap = true,
            silent = true,
            desc = 'Quick File Creator'
        })
    end
end

return M
