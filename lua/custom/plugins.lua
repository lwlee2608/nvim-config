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
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle render markdown" },
    },
  },
}
local lock = vim.json.decode(table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/lazy-lock.json")))
for name in pairs(lock) do
  table.insert(plugins, { name, pin = true })
end

return plugins
