if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

vim.g.clipboard = {
	name = "xsel",
	copy = {
		["+"] = "xsel --clipboard --input",
		["*"] = "xsel --clipboard --input",
	},
	paste = {
		["+"] = "xsel --clipboard --output",
		["*"] = "xsel --clipboard --output",
	},
	cache_enabled = 0,
}
