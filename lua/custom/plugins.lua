local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "clangd",
        "rust-analyzer",
        "mypy",
        "ruff",
        "pyright",
        "lua-language-server",
        "typescript-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
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
    cmd = "Copilot",
    event = "InsertEnter",
    opts = function()
      return require("custom.configs.copilot")
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "ThePrimeagen/99",
    lazy = false,
    config = function()
      local _99 = require("99")
      local providers = require("99.providers")
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup({
        provider = providers.OpenCodeProvider,
        model = "openrouter/moonshotai/kimi-k2.5",
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
      vim.keymap.set("n", "<leader>9p", function() _99.fill_in_function_prompt() end)
      vim.keymap.set("v", "<leader>9v", function() _99.visual() end)
      vim.keymap.set("v", "<leader>9p", function() _99.visual_prompt() end)
      vim.keymap.set("v", "<leader>9s", function() _99.stop_all_requests() end)
    end,
  },
}
return plugins
