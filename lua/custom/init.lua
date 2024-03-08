vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-]>", 'copilot#Accept("<CR>")', { silent = true, expr = true })


-- vim.g.vscode_snippets_path = "/home/anvnh/.config/Code/User/snippets/test1.code-snippets"

