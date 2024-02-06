-- basic
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--cybu
vim.keymap.set("n", "<s-tab>", "<Plug>(CybuPrev)", { desc = "Move to the Previous Buffer" })
vim.keymap.set("n", "<tab>", "<Plug>(CybuNext)", { desc = "Move to the Next Buffer" })
vim.keymap.set("n", "[b", "<plug>(CybuLastusedPrev)", { desc = "Move to the Previous Buffer" })
vim.keymap.set("n", "]b", "<plug>(CybuLastusedNext)", { desc = "Move to the Next Buffer" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to Previous Diagnostic Message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to Next Diagnostic Message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open Floating Diagnostic Message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostics List' })

--  Configure LSP
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
	nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

	nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
	nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
	nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, 'Workspace List Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

--leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward-to)', { remap = true, desc = "Leap Forward" })
vim.keymap.set({ 'n', 'x', 'o' }, '<S-s>', '<Plug>(leap-backward-to)', { remap = true, desc = "Leap Backward" })

-- copy all
vim.keymap.set('n', '<leader>yy', ':%y+<CR><CR>', { silent = true, remap = false, desc = "Yank the Entire Buffer" })

-- insert line above
vim.keymap.set('n', 'S-o', '^i<CR><Esc>k^i', { silent = true, remap = false, desc = "Insert Line Above]" })

-- resize splits
vim.keymap.set('n', '<M-Up>', ":resize -1<CR>", { silent = true, remap = false, desc = "Shrink the Window Horizontally" })
vim.keymap.set('n', '<M-Down>', ":resize +1<CR>", { silent = true, remap = false, desc = "Grow the Window Horizontally" })
vim.keymap.set('n', '<M-Left>', ":vertical resize -1<CR>",
	{ silent = true, remap = false, desc = "Shrink the Window Vertically" })
vim.keymap.set('n', '<M-Right>', ":vertical resize +1<CR>",
	{ silent = true, remap = false, desc = "Grow the Window Vertically" })

-- markdown previewer
vim.keymap.set('n', '<leader>m', ":Glow<CR>", { silent = true, remap = false, desc = "Open Glow" })

-- toggle formatting
vim.keymap.set('n', '<leader>ft', ":FormatToggle<CR>", { silent = false, remap = false, desc = "Format Toggle" })

-- move between splits
vim.keymap.set('n', '<C-Up>', ":wincmd k<CR>", { silent = false, remap = false, desc = "Move up a split" })
vim.keymap.set('n', '<C-Down>', ":wincmd j<CR>", { silent = false, remap = false, desc = "Move down a split" })
vim.keymap.set('n', '<C-Left>', ":wincmd h<CR>", { silent = false, remap = false, desc = "Move left a split" })
vim.keymap.set('n', '<C-Right>', ":wincmd l<CR>", { silent = false, remap = false, desc = "Move right a split" })

-- toggle colorcolumn
vim.keymap.set('n', '<leader>cc', function()
	if vim.wo.cc == "101" then
		vim.opt.colorcolumn = "0"
	else
		vim.opt.colorcolumn = "101"
	end
end, { desc = "Toggle Colorcolumn" })

-- gitsigns
vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
	{ desc = 'Go to Previous Hunk' })
vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { desc = 'Go to Next Hunk' })
vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { desc = 'Preview Hunk' })

-- Basic debugging keymaps
local dap = require 'dap'
local dapui = require 'dapui'
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
	dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })

-- telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
	{ desc = 'Find Recently Opened Files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
	{ desc = 'Find Existing Buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		previewer = false,
	})
end, { desc = 'Fuzzily Search in Current Buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search Current Word' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
