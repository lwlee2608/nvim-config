local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

-- Configure LSP servers using the new vim.lsp.config API
vim.lsp.config.gopls = {
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork", "gotmpl"},
  root_markers = {"go.work", "go.mod", ".git"},
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = false,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

vim.lsp.config.clangd = {
  filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto"},
}

vim.lsp.config.rust_analyzer = {
  filetypes = {"rust"},
  root_markers = {"Cargo.toml"},
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}

vim.lsp.config.pyright = {
  filetypes = {"python"},
  root_markers = {"setup.py", "setup.cfg", "pyproject.toml", "requirements.txt", ".git"},
  settings = {
    python = {
      venvPath = ".",
      pythonPath = "./.venv/bin/python",
    }
  }
}

vim.lsp.config.lua_ls = {
  filetypes = {"lua"},
  root_markers = {".git"},
}

vim.lsp.config.zls = {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_markers = {"zls.json", "build.zig", ".git"},
  single_file_support = true,
}

vim.lsp.config.tsserver = {
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
}

-- Enable LSP servers with on_attach and capabilities
vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("zls")
vim.lsp.enable("tsserver")

-- Set up autocommands to attach on_attach and capabilities
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Special handling for clangd
    if client.name == "clangd" then
      client.server_capabilities.signatureHelpProvider = false
    end

    -- Call the on_attach function
    on_attach(client, bufnr)
  end,
})
