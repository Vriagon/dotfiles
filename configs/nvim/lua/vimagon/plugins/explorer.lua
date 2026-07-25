return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>e",
			"<cmd>Yazi<cr>",
			desc = "Open Yazi",
		},
	},
	config = function()
		require("yazi").setup({
			open_for_directory = true,
		})
	end,
}
