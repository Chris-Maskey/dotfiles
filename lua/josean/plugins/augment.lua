return {
  "augmentcode/augment.vim",
  requires = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.g.augment_workspace_folders = { vim.fn.getcwd() }

    vim.keymap.set("n", "<leader>ac", ":Augment Chat<CR>", { desc = "Ask Augment a question" })
    vim.keymap.set("v", "<leader>ac", ":Augment Chat<CR>", { desc = "Ask Augment about selected code" })
    vim.keymap.set(
      "n",
      "<leader>at",
      ":Augment chat-toggle<CR>",
      { desc = "Toggle Augment Chat", noremap = true, silent = true }
    )
  end,
}
