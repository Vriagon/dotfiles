-- Interface
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.fillchars = { eob = " " }

-- System
vim.loader.enable()
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.confirm = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Normal/Visual = Block, Insert = Beam (both locked to "Cursor")
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor"

-- Apply fixed color to all cursor highlight groups
local cursor_style = { fg = "#000000", bg = "#7aa2f7", force = true }
vim.api.nvim_set_hl(0, "Cursor", cursor_style)
vim.api.nvim_set_hl(0, "lCursor", cursor_style)
vim.api.nvim_set_hl(0, "TermCursor", cursor_style)
