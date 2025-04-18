-- local M = {}
local opts = { noremap = true, silent = true }
local opt_nw = { noremap = true, silent = true, nowait = true }
local keymap = vim.keymap.set

-- Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

keymap("n", "<C-i>", "<C-i>", opts)

-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opt_nw)
keymap("n", "<C-j>", "<C-w>j", opt_nw)
keymap("n", "<C-k>", "<C-w>k", opt_nw)
keymap("n", "<C-l>", "<C-w>l", opt_nw)
keymap("n", "<C-j>", "<cmd> resize -2<CR>", opt_nw)
keymap("n", "<C-k>", "<cmd> resize +2<CR>", opt_nw)
keymap("n", "<S-h>", "<cmd> vertical resize -2<CR>", opt_nw)
keymap("n", "<S-l>", "<cmd> vertical resize +2<CR>", opt_nw)

-- Resize with arrows
-- keymap("n", "<S-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<S-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Better movement on the code
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "Y", 'y$ "', opts)
keymap("n", "J", "mzJ`z", opts)
keymap("c", "Q", "q", opt_nw)

--
-- -- Move text up and down
keymap("n", "<A-J>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-K>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert  Press jk fast to enter
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)
-- Move text up and down
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Node actions to toggle some values
keymap("n", "<C-x>", '<cmd>lua require("ts-node-action").node_action()<cr>', opts)

-- Floaterm
opts.desc = "Floaterm toogle"
-- keymap({ "n", "v" }, "<leader>T", "<cmd>FloatermToggle<cr>", opts)
-- keymap({ "n", "t" }, "<C-t>", "<cmd>FloatermToggle<cr>", opts)
keymap({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<cr>", opts)
keymap({ "n" }, "<leader>T", "<cmd>ToggleTerm<cr>", opts)

opts.desc = "Enter cmd mode"
keymap("n", "<leader>;", ":", opts)

-- remove S as a command
opts.desc = "Remove 's'"
keymap({ "n", "v", "x" }, "s", "<Esc>", opts)
opts.desc = "Remove q"
keymap({ "n", "v", "x" }, "q", "<Esc>", opts)

-- TABS and buffer Naviagation
--
opts.desc = "Previus buffer"
keymap("n", "<leader>1", "<c-^>", opt_nw)
-- keymap("n", "<TAB>", "<cmd>bnext<cr>", opts)
-- keymap("n", "<S-TAB>", "<cmd>bprevious<cr>", opts)
-- opt_nw.desc = "Previous buffer"
-- keymap("n", "<leader>bn", ":BufferNext<CR>", opts)
-- keymap("n", "<leader>bp", ":BufferPrevious<CR>", opts)
-- keymap("n", "<leader>bq", ":BufferFirst<CR>", opts)
--
opts.desc = "Telescope project"
keymap("n", "<localleader>p", ":Telescope projects theme=dropdown initial_mode=normal<CR>", opt_nw)
keymap("n", "<localleader>sp", "<cmd>Telescope projects theme=dropdown initial_mode=normal <cr>", opts)
-- keymap("n", "<leader>bd", ":bdelete<CR>", opts)
-- keymap("n", "<leader>bB", ":BufferCloseAllButCurrent<CR>", opts)

-- esc
opt_nw.desc = "Esc"
keymap("n", "<C-c>", "<Esc>", opt_nw)
opt_nw.desc = "Clear search"
keymap("n", "<Esc>", "<cmd>:noh<cr>", opt_nw)
keymap("n", "<C-c>", '<cmd>::let @/ = ""<cr>', opt_nw)

-- Map Ctrl+b in insert mode to delete to the end of the word without leaving insert mode
keymap("i", "<C-b>", "<C-o>de", opt_nw)

-- Map Ctrl+c to escape from other modes
-- keymap({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]], opt_nw)

-- select_all
keymap("n", "<C-a>", "gg<S-v>GY", opt_nw)

-- Alternate way to save
keymap("n", "<C-s>", "<cmd>w<cr>", opt_nw)
keymap({ "n", "i" }, "<D-s>", "<cmd>w<cr>")
keymap({ "n", "i" }, "<M-s>", "<cmd>w<cr>")
-- })
keymap("n", "<C-q>", "<cmd>:wq!<cr>", opt_nw)
keymap("n", "<leader>q", "<cmd>:wq!<cr>", opt_nw)

opt_nw.desc = "MyVimrc"
keymap("n", "<leader>0", "<cmd>e $MYVIMRC<cr>", opt_nw)

-- splits
-- keyakeymap("n", "<leader>v", "<C-W>v", opt_nw)
opt_nw.desc = "Vertical Split"
keymap("n", "<leader>v", "<cmd>vsplit<cr>", opt_nw)
opt_nw.desc = "Horizontal Split"
keymap("n", "<leader>ao", "<cmd>split<cr>", opt_nw)
opt_nw.desc = "Balance Window"
keymap("n", "<leader>a=", "<C-W>=", opt_nw)
opt_nw.desc = "Win up"
keymap("n", "<leader>ak", "<C-W>k", opt_nw)
opt_nw.desc = "Win left"
keymap("n", "<leader>aj", "<C-W>j", opt_nw)
opt_nw.desc = "Win right"
keymap("n", "<leader>al", "<C-W>l", opt_nw)
opt_nw.desc = "Cursorline"
keymap("n", "<leader>ac", "<cmd>lua require('user.core.functions').toggle_option('cursorline')<cr>", opt_nw)

-- keymap("n", "K", ":lua require('user.core.functions').show_documentation()<CR>", opts)
keymap("n", "Q", ":lua require('user.core.functions').smart_quit()<CR>", opts)

-- return M
