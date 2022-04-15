--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true

-- Toogleterm
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = 'vertical'
lvim.builtin.terminal.shade_terminals = true
lvim.builtin.terminal.size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end

-- NvimTree
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 50
lvim.builtin.nvimtree.setup.hijack_cursor = true
lvim.builtin.nvimtree.setup.update_focused_file.enable = true

-- Plugins
lvim.plugins = {
  {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'},
  {'vim-test/vim-test'},
  {"karb94/neoscroll.nvim"},
  {"ntk148v/vim-horizon"},
  {'ThePrimeagen/git-worktree.nvim'},
  {'rcarriga/nvim-dap-ui'},
  {'theHamsta/nvim-dap-virtual-text'},
  {'nvim-telescope/telescope-dap.nvim'},
  {'EdenEast/nightfox.nvim'},
  {'lukas-reineke/indent-blankline.nvim'},
  {"NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  }
}

-- git worktree
local Worktree = require("git-worktree")
Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end
end)

-- colorscheme
lvim.colorscheme = "nightfox"


-- scrolling
require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

vim.opt.list = true
--vim.opt.listchars:append("space:.")
--vim.opt.listchars:append("eol:?")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

-- Snippets
require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/vscodesnips" } }

-- Treesitter
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "json",
  "lua",
  "dart",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Flutter
-- alternatively you can override the default configs
require("flutter-tools").setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
    -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
    -- please note that this option is eventually going to be deprecated and users will need to
    -- depend on plugins like `nvim-notify` instead.
    notification_style = 'vim.notify'
  },
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = true,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = true,
    }
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
    --register_configurations = function(paths)
    --  require("dap").configurations.dart = {}
    --  --require("dap.ext.vscode").load_launchjs()
    --end,
  },
  --flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
  --flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "Comment", -- highlight for the closing tag
    prefix = "// ", -- character to use for close tag e.g. > Widget
    enabled = true -- set to false to disable
  },
  --dev_log = {
  --  enabled = true,
  --  open_cmd = "split", -- command to use to open the log buffer
  --},
  dev_tools = {
    autostart = true, -- autostart devtools server if not detected
    auto_open_browser = true, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = true, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    --on_attach = my_custom_on_attach,
    --capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
    --- OR you can specify a function to deactivate or change or control how the config is created
    capabilities = function(config)
      config.specificThingIDontWant = false
      return config
    end,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      --analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
    }
  }
}

require("telescope").load_extension("flutter")

local dap_install = require("dap-install")

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})



local map = vim.api.nvim_set_keymap
-- Tests
map('n', '<Leader>t', ':TestNearest<CR>', { noremap = true, silent = true })
map('n', '<Leader>ta', ':TestFile<CR>', { noremap = true, silent = true })

-- HTTP requests
map('n', '<Leader>r', ":lua require('rest-nvim').run()<CR>" , { noremap = true, silent = true })


-- Flutter run
--map("n", "<F5>", ":FlutterRun --flavor staging --dart-define flavor=staging --no-sound-null-safety<CR>", {noremap=true, silent=true})
map("n", "<F5>", ":FlutterRun --flavor prod --dart-define flavor=prod --dart-define forceLog=true --no-sound-null-safety<CR>", {noremap=true, silent=true})

-- Debug
map("n", "<F6>", ":lua require'dap'.continue()<CR>", {noremap=true, silent=true})
map("n", "<F9>", ":lua require'dap'.step_over()<CR>", {noremap=true, silent=true})
map("n", "<F10>", ":lua require'dap'.step_into()<CR>", {noremap=true, silent=true})
map("n", "<F12>", ":lua require'dap'.step_out()<CR>", {noremap=true, silent=true})
map("n", "<leader>a", ":lua require'dap'.toggle_breakpoint()<CR>", {noremap=true, silent=true})
map("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {noremap=true, silent=true})
map("n", "<leader>dp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", {noremap=true, silent=true})
map("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", {noremap=true, silent=true})

local dap = require('dap')
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup()


vim.opt.termguicolors = true
