local map = vim.keymap.set

map("n", ";", ":")
map("n", "<leader>w", "<Cmd>write<CR>", { silent = true })
map("n", "<leader>s", "<Cmd>Format<CR>", { silent = true })
map("n", "<leader>e", "<Cmd>Lazy sync<CR>", { silent = true })
map("n", "<leader>q", "<Cmd>confirm bdelete<CR>", { silent = true })
map("n", "<C-q>", "<Cmd>confirm quit<CR>", { silent = true })
map("n", "<Tab>", "<Cmd>bnext<CR>", { silent = true })
map("n", "<S-Tab>", "<Cmd>bprevious<CR>", { silent = true })
map("n", "<Esc>", "<Esc><Cmd>noh<CR><Esc>", { silent = true })
map("n", "<CR>", "o<Esc>", { silent = true })
map("n", "<S-CR>", "O<Esc>", { silent = true })

map("n", "<leader>gd", "<Cmd>Gdiffsplit<CR>", { silent = true })
map("n", "<leader>gb", "<Cmd>Git blame<CR>", { silent = true })

map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

map("i", "<C-h>", "<C-\\><C-n><Cmd>TmuxNavigateLeft<CR>", { silent = true })
map("i", "<C-j>", "<C-\\><C-n><Cmd>TmuxNavigateDown<CR>", { silent = true })
map("i", "<C-k>", "<C-\\><C-n><Cmd>TmuxNavigateUp<CR>", { silent = true })
map("i", "<C-l>", "<C-\\><C-n><Cmd>TmuxNavigateRight<CR>", { silent = true })

map("n", "\\", "<leader>q", { remap = true, silent = true })

map("n", "<F2>", function()
    local search = vim.fn.getreg("/")
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setreg("/", search)
end, { silent = true, desc = "Trim trailing spaces" })
