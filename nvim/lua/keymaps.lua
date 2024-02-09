local mappings = {}

-- [keymap] = {"command", { options}}
mappings.nav = {
    ["<space>"] = { "<Nop>" },
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", { expr = true } },
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", { expr = true } },
    ["<C-Up>"] = { ":resize -1<CR>", { silent = true, remap = false, desc = "Shrink the Window Horizontally" } },
    ["<C-Down>"] = { ":resize +1<CR>", { silent = true, remap = false, desc = "Grow the Window Horizontally" } },
    ["<C-Left>"] = { ":vertical resize -1<CR>", { silent = true, remap = false, desc = "Shrink the Window Vertically" } },
    ["<C-Right>"] = { ":vertical resize +1<CR>", { silent = true, remap = false, desc = "Grow the Window Vertically" } },
    ["<C-k>"] = { ":wincmd k<CR>", { silent = false, remap = false, desc = "Move up a split" } },
    ["<C-j>"] = { ":wincmd j<CR>", { silent = false, remap = false, desc = "Move down a split" } },
    ["<C-h>"] = { ":wincmd h<CR>", { silent = false, remap = false, desc = "Move left a split" } },
    ["<C-l>"] = { ":wincmd l<CR>", { silent = false, remap = false, desc = "Move right a split" } },
    ["q:"] = { "<Nop>" },
    ["<leader>cc"] = { function()
        if vim.wo.cc == "101" then
            vim.opt.colorcolumn = "0"
        else
            vim.opt.colorcolumn = "101"
        end
    end, { desc = "Toggle Colorcolumn" } },
}

mappings.custom = {
    ["<leader>yy"] = { ":%y+<CR><CR>", { silent = true, remap = false, desc = "Yank the Entire Buffer" } },
    ["S-o"] = { "^i<CR><Esc>k^i", { silent = true, remap = false, desc = "Insert Line Above" } },
    ["<leader>ft"] = { ":FormatToggle<CR>", { silent = false, remap = false, desc = "Format Toggle" } },
}

mappings.cybu = {
    ["<s-tab>"] = { "<Plug>(CybuPrev)", { desc = "Move to the Previous Buffer" } },
    ["<tab>"] = { "<Plug>(CybuNext)", { desc = "Move to the Next Buffer" } },
    ["[b"] = { "<plug>(CybuLastusedPrev)", { desc = "Move to the Previous Buffer" } },
    ["]b"] = { "<plug>(CybuLastusedNext)", { desc = "Move to the Next Buffer" } },
}

mappings.diagnostic = {
    ["[d"] = { vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic Message" } },
    ["]d"] = { vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic Message" } },
    ["<leader>e"] = { vim.diagnostic.open_float, { desc = "Open Floating Diagnostic Message" } },
    ["<leader>q"] = { vim.diagnostic.setloclist, { desc = "Open Diagnostics List" } },
}

mappings.leap = {
    ["s"] = { "<Plug>(leap-forward-to)", { remap = true, desc = "Leap Forward" } },
    ["<S-s>"] = { "<Plug>(leap-backward-to)", { remap = true, desc = "Leap Backward" } },
}

mappings.glow = {
    ["<leader>m"] = { ":Glow<CR>", { silent = true, remap = false, desc = "Open Glow" } },
}

mappings.gitsigns = {
    ["[g"] = { require("gitsigns").prev_hunk, { desc = "Go to Previous Hunk" } },
    ["]g"] = { require("gitsigns").next_hunk, { desc = "Go to Next Hunk" } },
    ["<leader>ph"] = { require("gitsigns").preview_hunk, { desc = "Preview Hunk" } },
}

mappings.debugging = {
    ["<F7>"] = { require("dapui").toggle, { desc = "Debug" } },
    ["<F5>"] = { require("dap").continue, { desc = "Debug" } },
    ["<F1>"] = { require("dap").step_into, { desc = "Debug" } },
    ["<F2>"] = { require("dap").step_over, { desc = "Debug" } },
    ["<F3>"] = { require("dap").step_out, { desc = "Debug" } },
    ["<leader>b"] = { require("dap").toggle_breakpoint, { desc = "Debug" } },
    ["<leader>B"] = { function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end, { desc = "Debug: Set Breakpoint" } },
}

mappings.telescope = {
    ["<leader>?"] = { require("telescope.builtin").oldfiles, { desc = "Find Recently Opened Files" } },
    ["<leader><space>"] = { require("telescope.builtin").buffers, { desc = "Find Existing Buffers" } },
    ["<leader>gf"] = { require("telescope.builtin").git_files, { desc = "Search Git Files" } },
    ["<leader>ff"] = { require("telescope.builtin").find_files, { desc = "Search Files" } },
    ["<leader>sh"] = { require("telescope.builtin").help_tags, { desc = "Search Help" } },
    ["<leader>sw"] = { require("telescope.builtin").grep_string, { desc = "Search Current Word" } },
    ["<leader>sg"] = { require("telescope.builtin").live_grep, { desc = "Search by Grep" } },
    ["<leader>sd"] = { require("telescope.builtin").diagnostics, { desc = "Search Diagnostics" } },
    ["<leader>/"] = { function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
            previewer = false,
        })
    end, { desc = "Fuzzily Search in Current Buffer" } },
}

mappings.lsp = {
    ["<leader>rn"] = { vim.lsp.buf.rename, { desc = "Rename" } },
    ["<leader>ca"] = { vim.lsp.buf.code_action, { desc = "Code Action" } },
    ["gd"] = { vim.lsp.buf.definition, { desc = "Goto Definition" } },
    ["gr"] = { require("telescope.builtin").lsp_references, { desc = "Goto References" } },
    ["gI"] = { vim.lsp.buf.implementation, { desc = "Goto Implementation" } },
    ["<leader>D"] = { vim.lsp.buf.type_definition, { desc = "Type Definition" } },
    ["<leader>ds"] = { require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" } },
    ["<leader>ws"] = { require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" } },
    ["K"] = { vim.lsp.buf.hover, { desc = "Hover Documentation" } },
    ["<C-k>"] = { vim.lsp.buf.signature_help, { desc = "Signature Documentation" } },
    ["gD"] = { vim.lsp.buf.declaration, { desc = "Goto Declaration" } },
    ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, { desc = "Workspace Add Folder" } },
    ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, { desc = "Workspace Remove Folder" } },
    ["<leader>wl"] = { function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "Workspace List Folders" } },
}

-- prefix lsp descriptions with "LSP: "
for _, lsp_opts in pairs(mappings.lsp) do
    lsp_opts[2].desc = "LSP: " .. lsp_opts[2].desc
end

return mappings
