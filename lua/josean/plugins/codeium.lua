-- return {
-- "Exafunction/codeium.vim",
-- event = "BufEnter",
-- config = function()
--   vim.keymap.set("i", "<Tab>", function()
--     return vim.fn["codeium#Accept"]()
--   end, { expr = true, silent = true })
--   vim.keymap.set("i", "<c-;>", function()
--     return vim.fn["codeium#CycleCompletions"](1)
--   end, { expr = true, silent = true })
--   vim.keymap.set("i", "<c-,>", function()
--     return vim.fn["codeium#CycleCompletions"](-1)
--   end, { expr = true, silent = true })
--   vim.keymap.set("i", "<c-x>", function()
--     return vim.fn["codeium#Clear"]()
--   end, { expr = true, silent = true })
--   vim.g.codeium_filetypes = {
--     markdown = false,
--   }
-- end,
-- }

return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    vim.keymap.set("i", "<Tab>", neocodeium.accept)
  end,
}
