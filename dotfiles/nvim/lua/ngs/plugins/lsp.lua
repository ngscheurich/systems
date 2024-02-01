return {
  "neovim/nvim-lspconfig",

  dependencies = {
    { "folke/neodev.nvim", opts = {} },
    { "williamboman/mason.nvim", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        automatic_installation = { exclude = { "rnix" } },
      },
    },
    "folke/which-key.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },

  opts = {
    servers = {},
  },

  config = function(_, opts)
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    for server, config in pairs(opts.servers) do
      lspconfig[server].setup(vim.tbl_extend("keep", config, {
        capabilities = capabilities,
      }))
    end

    local function on_attach(buffer)
      local pick = require("ngs.util").pick
      local telescope = require("telescope.builtin")

      local mappings = {
        ["<LocalLeader>"] = {
          name = "lsp",
          S = { telescope.lsp_workspace_symbols, "Workspace symbols" },
          a = { vim.lsp.buf.code_action, "Actions" },
          d = { vim.diagnostic.open_float, "Diagnostics" },
          f = {
            function()
              vim.lsp.buf.format({ async = true })
            end,
            "Format",
          },
          r = { telescope.lsp_references, "References" },
          s = { pick("lsp_document_symbols", "get_dropdown", { previewer = false }), "Document symbols" },
        },

        K = { vim.lsp.buf.hover, "Hover" },
        ["[d"] = { vim.lsp.diagnostic.goto_prev, "Prev diagnostic" },
        ["]d"] = { vim.lsp.diagnostic.goto_next, "Next diagnostic" },
      }

      require("which-key").register(mappings, { buffer = buffer })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(event)
        on_attach(event.buffer)
      end,
    })
  end,
}
