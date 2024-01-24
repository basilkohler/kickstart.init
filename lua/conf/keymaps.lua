-- Remap for dealing with word wrap
--map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


-- move selected lines up or down
map("v", "<C-j>", ":m '>+1<CR>gv=gv", "Move selected line down")
map("v", "<C-k>", ":m '<-2<CR>gv=gv", "Move selected line up")

-- open file explorer
map("n", "<leader>fe", vim.cmd.Ex, "[F]ind in file [E]xplorer")

-- copy to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], "yank to clipboard")
map("n", "<leader>Y", [["+Y]], "upper case yank to clipboard")
map({ "n", "v" }, "<leader>d", [["+d]], "delete to clipboard")
map("n", "<leader>D", [["+D]], "delete eol to clipboard")

-- go back
map("n", "gb", "<C-o>", "[G]o [B]ack")


-- [[ existing command improvements ]]

-- join lines with cursor staying at the start
map("n", "J", "mzJ`z")

-- move cursor to middle when going half page down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- move cursor to middle when going to next
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- in visual block select, when C-c it does not save changes (like it does with ESC)
map("i", "<C-c>", "<Esc>")

-- disable 'replay last recorded macro'
map("n", "Q", "<nop>")

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

