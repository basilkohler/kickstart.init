-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'java', 'templ' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-s>',
            node_incremental = '<c-s>',
            scope_incremental = '<c-m>',
            node_decremental = '<c-l>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- go templ
local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
treesitter_parser_config.templ = {
    install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
    },
}

vim.treesitter.language.register('templ', 'templ')
