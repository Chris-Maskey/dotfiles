-- return {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     { "antosha417/nvim-lsp-file-operations", config = true },
--     { "folke/neodev.nvim", opts = {} },
--   },
--   config = function()
--     -- import lspconfig plugin
--     local lspconfig = require("lspconfig")
--
--     -- import mason_lspconfig plugin
--     local mason_lspconfig = require("mason-lspconfig")
--
--     -- import cmp-nvim-lsp plugin
--     local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
--     local keymap = vim.keymap -- for conciseness
--
--     vim.api.nvim_create_autocmd("LspAttach", {
--       group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--       callback = function(ev)
--         -- Buffer local mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions
--         local opts = { buffer = ev.buf, silent = true }
--
--         -- set keybinds
--         opts.desc = "Show LSP references"
--         keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
--
--         opts.desc = "Go to declaration"
--         keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
--
--         opts.desc = "Show LSP definitions"
--         keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
--
--         opts.desc = "Show LSP implementations"
--         keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
--
--         opts.desc = "Show LSP type definitions"
--         keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
--
--         opts.desc = "See available code actions"
--         keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
--
--         opts.desc = "Smart rename"
--         keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
--
--         opts.desc = "Show buffer diagnostics"
--         keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
--
--         opts.desc = "Show line diagnostics"
--         keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
--
--         opts.desc = "Go to previous diagnostic"
--         keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
--
--         opts.desc = "Go to next diagnostic"
--         keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
--
--         opts.desc = "Show documentation for what is under cursor"
--         keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
--
--         opts.desc = "Restart LSP"
--         keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
--       end,
--     })
--
--     -- used to enable autocompletion (assign to every lsp server config)
--     local capabilities = cmp_nvim_lsp.default_capabilities()
--
--     -- Change the Diagnostic symbols in the sign column (gutter)
--     -- (not in youtube nvim video)
--     local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
--     for type, icon in pairs(signs) do
--       local hl = "DiagnosticSign" .. type
--       vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--     end
--
--     mason_lspconfig.setup_handlers({
--       -- default handler for installed servers
--       function(server_name)
--         lspconfig[server_name].setup({
--           capabilities = capabilities,
--         })
--       end,
--       ["svelte"] = function()
--         -- configure svelte server
--         lspconfig["svelte"].setup({
--           capabilities = capabilities,
--           on_attach = function(client, bufnr)
--             vim.api.nvim_create_autocmd("BufWritePost", {
--               pattern = { "*.js", "*.ts" },
--               callback = function(ctx)
--                 -- Here use ctx.match instead of ctx.file
--                 client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
--               end,
--             })
--           end,
--         })
--       end,
--       ["graphql"] = function()
--         -- configure graphql language server
--         lspconfig["graphql"].setup({
--           capabilities = capabilities,
--           filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
--         })
--       end,
--       ["emmet_ls"] = function()
--         -- configure emmet language server
--         lspconfig["emmet_ls"].setup({
--           capabilities = capabilities,
--           filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
--         })
--       end,
--       ["lua_ls"] = function()
--         -- configure lua server (with special settings)
--         lspconfig["lua_ls"].setup({
--           capabilities = capabilities,
--           settings = {
--             Lua = {
--               -- make the language server recognize "vim" global
--               diagnostics = {
--                 globals = { "vim" },
--               },
--               completion = {
--                 callSnippet = "Replace",
--               },
--             },
--           },
--         })
--       end,
--     })
--   end,
-- }

return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" }, -- Required
    { -- Optional
      "williamboman/mason.nvim",
      build = function()
        pcall(vim.cmd, "MasonUpdate")
      end,
    },
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" }, -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" }, -- Required
    { "rafamadriz/friendly-snippets" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },
  },
  config = function()
    local lsp = require("lsp-zero")

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      local keymap = vim.keymap -- for conciseness

      -- vim.keymap.set("n", "gr", function()
      --   vim.lsp.buf.references()
      -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
      -- vim.keymap.set("n", "gd", function()
      --   vim.keymap.set("n", "K", function()
      --     vim.lsp.buf.hover()
      --   end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
      --   vim.keymap.set("n", "<leader>vws", function()
      --     vim.lsp.buf.workspace_symbol()
      --   end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
      --   vim.keymap.set("n", "<leader>vd", function()
      --     vim.diagnostic.setloclist()
      --   end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
      --   vim.keymap.set("n", "<leader>d", function()
      --     vim.diagnostic.goto_next()
      --   end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
      --   vim.keymap.set("n", "]d", function()
      --     vim.diagnostic.goto_prev()
      --   end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
      --   vim.keymap.set("n", "<leader>vca", function()
      --     vim.lsp.buf.code_action()
      --   end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
      --   vim.lsp.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
      --   vim.lsp.buf.references()
      -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
      -- vim.keymap.set("n", "<leader>vrn", function()
      --   vim.lsp.buf.rename()
      -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
      -- vim.keymap.set("i", "<C-h>", function()
      --   vim.lsp.buf.signature_help()
      -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end)

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "eslint",
        "rust_analyzer",
        "kotlin_language_server",
        "jdtls",
        "lua_ls",
        "ts_ls",
        "prismals",
        "jsonls",
        "elixirls",
        "tailwindcss",
        "tflint",
        "pylsp",
        "html",
        "cssls",
        "dockerls",
        "bashls",
        "marksman",
        "gopls",
        "astro",
      },
      handlers = {
        lsp.default_setup,
        lua_ls = function()
          local lua_opts = lsp.nvim_lua_ls()
          require("lspconfig").lua_ls.setup(lua_opts)
        end,
      },
    })

    local cmp_action = require("lsp-zero").cmp_action()
    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    require("luasnip.loaders.from_vscode").lazy_load()

    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
      },

      -- mapping = cmp.mapping.preset.insert({
      --   ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
      --   ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
      --   ["<CR>"] = cmp.mapping.confirm({ select = true }),
      --   ["<C-Space>"] = cmp.mapping.complete(),
      --   ["<C-f>"] = cmp_action.luasnip_jump_forward(),
      --   ["<C-b>"] = cmp_action.luasnip_jump_backward(),
      --   ["<Tab>"] = cmp_action.luasnip_supertab(),
      --   ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
      -- }),
    })
  end,
}
