-- [[ Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = {         -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --glob " }),
                },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
        },
        file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    }
}

-- telescope.setup {
--   defaults = {
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--       },
--     },
--   },
--   extensions = {
--     live_grep_args = {
--       auto_quoting = true,
--       mappings = {
--         i = {
--           ["<C-k>"] = lga_actions.quote_prompt(),
--           ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
--         },
--       },
--     },
--   },
-- }

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension "file_browser"
require("telescope").load_extension "live_grep_args"

-- See `:help telescope.builtin`
map('n', '<leader>fr', require('telescope.builtin').oldfiles, '[F]ind [R]ecently opened files')
map('n', '<leader>fo', require('telescope.builtin').buffers, '[F]ind [O]pen buffers')

local function telescope_ff()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end

local function telescope_project()
    require('telescope.builtin').git_files({ show_untracked = true })
end

local function oil_open_float()
    local oil = require('oil')
    oil.toggle_float(oil.get_current_dir())
end

local function grep_word_under_cursor()
    return require('telescope').extensions.live_grep_args.live_grep_args()
end

map('n', '<leader>/', oil_open_float, { desc = "Open Oil in float" })
map('n', '<leader>fb', telescope_ff, '[F]ind Fuzzily in current [b]uffer')
map('n', '<leader>ff', telescope_project, '[F]ind Git [F]iles')
map('n', '<leader>fa', require('telescope.builtin').find_files, '[F]ind all [F]iles')
map('n', '<leader>fh', require('telescope.builtin').help_tags, '[F]ind [H]elp')
map('n', '<leader>fw', require('telescope.builtin').grep_string, '[F]ind current [W]ord')
map("n", "<leader>gc", grep_word_under_cursor, '[F]ind under cursor')
map('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", '[F]ind by [G]rep')
map('n', '<leader>sd', require('telescope.builtin').diagnostics, '[S]how [D]iagnostics')
