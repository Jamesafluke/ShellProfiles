-- Autosave
vim.o.autowriteall = true



-- Ctrl+Backspace = delete previous word
vim.keymap.set('i', '<C-BS>', '<C-w>', { desc = 'Delete previous word (Insert)' })
vim.keymap.set('c', '<C-BS>', '<C-w>', { desc = 'Delete previous word (Cmdline)' })

-- Ctrl+Delete = delete next word
vim.keymap.set('i', '<C-Del>', '<C-o>de', { desc = 'Delete next word (Insert)' })
vim.keymap.set('c', '<C-Del>', '<S-Right><C-w>', { desc = 'Delete next word (Cmdline)' })



--ctl w for closing tabs in VSCode
vim.keymap.set("n", "<C-w>", "<Nop>", { silent = true })

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true

--Indent selected lines but stay selected.
local opts = { noremap = true, silent = true }
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<', '<gv', opts)

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

--Keep cursor centered while jumping.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


vim.opt.ignorecase = true
vim.opt.smartcase = true


vim.opt.scrolloff = 18


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
