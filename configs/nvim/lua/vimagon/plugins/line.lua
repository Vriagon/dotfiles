return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename", "branch", "diff" },
				lualine_c = {},
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = {},
				lualine_z = { "location" },
			},
		})
	end,
}
