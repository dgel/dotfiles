
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup()
    end
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use {
    'airblade/vim-rooter',
    config = function()
      vim.g.rooter_silent_chdir = 1
    end
  }
--use 'wellle/targets.vim'
  use {
    'Raimondi/delimitMate',
    config = function() 
      vim.g.delimitMate_expand_cr = 1
      vim.g.delimitMate_expand_space = 1
    end
  }
  use {
    'SirVer/ultisnips', 
    requires = { 'honza/vim-snippets' },
    config = function()
      -- snippet trigger config
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<c-n>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-p>"
      -- snippet search locations
      vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "my_ultisnips"}
    end
  }
  use 'mbbill/undotree'
  use { 
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd([[ colorscheme tokyonight ]])
    end
  }
  use { 
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'flex',
          layout_config = { width = 0.95 },
          path_display = {'smart'},
        },
      }

      options = { noremap = true }
      -- >> Telescope bindings
      vim.api.nvim_set_keymap('n', '<leader>pp', [[<cmd>lua require'telescope.builtin'.builtin{}<CR>]], options)
      -- most recently used files
      vim.api.nvim_set_keymap('n', '<leader>fr', [[<cmd>lua require'telescope.builtin'.oldfiles{}<CR>]], options)
      -- find buffer
      vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require'telescope.builtin'.buffers{}<CR>]], options)
      -- find in current buffer
      vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>]], options)
      -- bookmarks
      -- vim.api.nvim_set_keymap('n', '<leader>', [[<cmd>lua require'telescope.builtin'.marks{}<CR>]], options)
      -- git files
      vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require'telescope.builtin'.git_files{}<CR>]], options)
      -- all files
      vim.api.nvim_set_keymap('n', '<c-p>', [[<cmd>lua require'telescope.builtin'.find_files{}<CR>]], options)
      -- ripgrep like grep through dir
      vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require'telescope.builtin'.live_grep{}<CR>]], options)
    end
  }


  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() 
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ia"] = "@alternative",
              ["ie"] = "@expansion",
            }
          }
        }
      }
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.jsgf = {
        install_info = {
          url = "/nlu/users/douwe_gelling/moretools/not_nlu/editor_configurations/nvim/tree-sitter-jsgf",
          files = {"src/parser.c"}
        },
        filetype = "jsgf",
      }

      -- color errors in red when not in insert mode
      vim.cmd([[hi! link TSError Error]])
      vim.cmd([[autocmd InsertEnter * hi! link TSError Normal]])
      vim.cmd([[autocmd InsertLeave * hi! link TSError Error]])
    end
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    'nvim-treesitter/playground',
    opt = true,
    cmd = 'TSPlaygroundToggle'
  }
  
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      lsp_installer = require("nvim-lsp-installer")
      lsp_installer.on_server_ready(function(server)
        local opts = {}
        -- customise opts here
        server:setup(opts)
      end)
    end
  }
  use {
    'neovim/nvim-lspconfig',
    requires = 'hrsh7th/cmp-nvim-lsp',
    config = function() 
      vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua vim.diagnostic.open_float()<CR>]], { noremap = true })
    end
  }
  use { 
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.code_actions.shellcheck
        }
      })
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      vim.o.completeopt = 'menu,menuone,noselect'

      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'ultisnips' }, -- For ultisnips users.
        }, {
          { name = 'buffer', keyword_length = 3 },
          { name = 'path' },
        }),

        window = {
          completion = { border = 'rounded' },
          documentation = { border = 'rounded' }
        }
      })
    end
  }
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
  use { 'quangnguyen30192/cmp-nvim-ultisnips', after = 'nvim-cmp' }

end)
