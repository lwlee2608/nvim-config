local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "rust-analyzer",
        "mypy",
        "ruff",
        "pyright",
        "lua-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    commit = "54617a1",  -- Oct 2024, compatible with Nvim 0.10.x
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    -- "jose-elias-alvarez/null-ls.nvim",
    "nvimtools/none-ls.nvim",
    ft = { "go", "javascript", "typescript", "json", "ruby", "lua", "markdown" },
    opts = function()
        return require("custom.configs.null-ls")
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    commit = "f8d8d87",  -- Oct 2024, stable version
    cmd = "Copilot",
    event = "InsertEnter",
    opts = function()
      return require("custom.configs.copilot")
    end,
  },
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
  },
  -- {
  --   'Exafunction/windsurf.vim',
  --   event = 'BufEnter'
  -- },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    dir = "/Users/lwlee2608/src/github/99",
    lazy = false,
    config = function()
      local _99 = require("99")
      local providers = require("99.providers")
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup({
        provider = providers.ClaudeCodeProvider,
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },
        completion = {
          source = "cmp",
        },
        md_files = {
          "AGENT.md",
        },
      })

      vim.keymap.set("n", "<leader>9f", function() _99.fill_in_function() end)
      vim.keymap.set("v", "<leader>9v", function() _99.visual() end)
      vim.keymap.set("v", "<leader>9s", function() _99.stop_all_requests() end)
    end,
  },
}
return plugins
