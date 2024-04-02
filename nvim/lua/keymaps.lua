local mappings = {}

-- [{{modes}, keymap}] = {"command", {options}}
mappings.nav = {
    [{ { "n", "v" }, "k" }] = { "v:count == 0 ? 'gk' : 'k'", { expr = true } },
    [{ { "n", "v" }, "j" }] = { "v:count == 0 ? 'gj' : 'j'", { expr = true } },
    [{ { "n" }, "<C-Up>" }] = { ":resize -1<CR>", { silent = true, remap = false, desc = "Shrink the Window Horizontally" } },
    [{ { "n" }, "<C-Down>" }] = { ":resize +1<CR>", { silent = true, remap = false, desc = "Grow the Window Horizontally" } },
    [{ { "n" }, "<C-Left>" }] = { ":vertical resize -1<CR>", { silent = true, remap = false, desc = "Shrink the Window Vertically" } },
    [{ { "n" }, "<C-Right>" }] = { ":vertical resize +1<CR>", { silent = true, remap = false, desc = "Grow the Window Vertically" } },
    [{ { "n" }, "<C-k>" }] = { ":wincmd k<CR>", { silent = false, remap = false, desc = "Move up a split" } },
    [{ { "n" }, "<C-j>" }] = { ":wincmd j<CR>", { silent = false, remap = false, desc = "Move down a split" } },
    [{ { "n" }, "<C-h>" }] = { ":wincmd h<CR>", { silent = false, remap = false, desc = "Move left a split" } },
    [{ { "n" }, "<C-l>" }] = { ":wincmd l<CR>", { silent = false, remap = false, desc = "Move right a split" } },
    [{ { "n" }, "<C-w>h" }] = { ":sp <CR>", { silent = true, remap = false, desc = "Split Window Horizontally" } },
}

mappings.custom = {
    [{ { "n" }, "<leader>yy" }] = { ":%y+<CR><CR>", { silent = true, remap = false, desc = "Yank the Entire Buffer" } },
    [{ { "n" }, "<S-o>" }] = { "^i<CR><Esc>k^i", { silent = true, remap = false, desc = "Insert Line Above" } },
    [{ { "n" }, "q:" }] = { "<Nop>" },
    [{ { "n" }, "<space>" }] = { "<Nop>" },
    [{ { "n" }, "<leader>cc" }] = { function()
        if vim.wo.cc == "101" then
            vim.opt.colorcolumn = "0"
        else
            vim.opt.colorcolumn = "101"
        end
    end, { desc = "Toggle Colorcolumn" } },
}

mappings.cybu = {
    [{ { "n" }, "<s-tab>" }] = { "<Plug>(CybuPrev)", { desc = "Move to the Previous Buffer" } },
    [{ { "n" }, "<tab>" }] = { "<Plug>(CybuNext)", { desc = "Move to the Next Buffer" } },
    [{ { "n" }, "[b" }] = { "<plug>(CybuLastusedPrev)", { desc = "Move to the Previous Buffer" } },
    [{ { "n" }, "]b" }] = { "<plug>(CybuLastusedNext)", { desc = "Move to the Next Buffer" } },
}

mappings.diagnostic = {
    [{ { "n" }, "[d" }] = { vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic Message" } },
    [{ { "n" }, "]d" }] = { vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic Message" } },
    [{ { "n" }, "<leader>dm" }] = { vim.diagnostic.open_float, { desc = "Open Floating Diagnostic Message" } },
    [{ { "n" }, "<leader>dl" }] = { vim.diagnostic.setloclist, { desc = "Open Diagnostics List" } },
}

mappings.leap = {
    [{ { "n", "v" }, "s" }] = { "<Plug>(leap-forward-to)", { remap = true, desc = "Leap Forward" } },
    [{ { "n", "v" }, "<S-s>" }] = { "<Plug>(leap-backward-to)", { remap = true, desc = "Leap Backward" } },
}

mappings.glow = {
    [{ { "n" }, "<leader>m" }] = { function()
        if (vim.bo.filetype == "markdown") then
            vim.cmd("Glow")
        end
    end, { silent = true, remap = false, desc = "Open Glow" } },
}

mappings.gitsigns = {
    [{ { "n" }, "[g" }] = { require("gitsigns").prev_hunk, { desc = "Go to Previous Hunk" } },
    [{ { "n" }, "]g" }] = { require("gitsigns").next_hunk, { desc = "Go to Next Hunk" } },
    [{ { "n" }, "<leader>ph" }] = { require("gitsigns").preview_hunk, { desc = "Preview Hunk" } },
}

mappings.debugging = {
    [{ { "n" }, "<F7>" }] = { require("dapui").toggle, { desc = "Toggle DapUi" } },
    [{ { "n" }, "<F6>" }] = { require("dap").terminate, { desc = "Terminate Dap" } },
    [{ { "n" }, "<F5>" }] = { require("dap").continue, { desc = "Continue Dap" } },
    [{ { "n" }, "<F1>" }] = { require("dap").step_into, { desc = "Step Into" } },
    [{ { "n" }, "<F2>" }] = { require("dap").step_over, { desc = "Step Over" } },
    [{ { "n" }, "<F3>" }] = { require("dap").step_out, { desc = "Step Out" } },
    [{ { "n" }, "<leader>b" }] = { require("dap").toggle_breakpoint, { desc = "Toggle Breakpoint" } },
    [{ { "n" }, "<leader>B" }] = { function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end, { desc = "Set Breakpoint Condition" } },
}

mappings.telescope = {
    [{ { "n" }, "<leader>?" }] = { require("telescope.builtin").oldfiles, { desc = "Find Recently Opened Files" } },
    [{ { "n" }, "<leader><space>" }] = { require("telescope.builtin").buffers, { desc = "Find Existing Buffers" } },
    [{ { "n" }, "<leader>ff" }] = { require("telescope.builtin").find_files, { desc = "Search Files" } },
    [{ { "n" }, "<leader>gf" }] = { require("telescope.builtin").git_files, { desc = "Search Git Files" } },
    [{ { "n" }, "<leader>sh" }] = { require("telescope.builtin").help_tags, { desc = "Search Help" } },
    [{ { "n" }, "<leader>sw" }] = { require("telescope.builtin").grep_string, { desc = "Search Current Word" } },
    [{ { "n" }, "<leader>sg" }] = { require("telescope.builtin").live_grep, { desc = "Search by Grep" } },
    [{ { "n" }, "<leader>sd" }] = { require("telescope.builtin").diagnostics, { desc = "Search Diagnostics" } },
    [{ { "n" }, "<leader>/" }] = { function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
            previewer = false,
        })
    end, { desc = "Fuzzily Search in Current Buffer" } },
}

mappings.lsp = {
    [{ { "n" }, "<leader>rn" }] = { vim.lsp.buf.rename, { desc = "Rename" } },
    [{ { "n" }, "<leader>fb" }] = { vim.lsp.buf.format, { remap = false, desc = "Format buffer" } },
    [{ { "n" }, "<leader>ca" }] = { vim.lsp.buf.code_action, { desc = "Code Action" } },
    [{ { "n" }, "<leader>td" }] = { vim.lsp.buf.type_definition, { desc = "Type Definition" } },

    -- Goto
    [{ { "n" }, "gd" }] = { vim.lsp.buf.definition, { desc = "Goto Definition" } },
    [{ { "n" }, "gD" }] = { vim.lsp.buf.declaration, { desc = "Goto Declaration" } },
    [{ { "n" }, "gr" }] = { require("telescope.builtin").lsp_references, { desc = "Goto References" } },
    [{ { "n" }, "gI" }] = { vim.lsp.buf.implementation, { desc = "Goto Implementation" } },

    -- Symbols
    [{ { "n" }, "<leader>ds" }] = { require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" } },
    [{ { "n" }, "<leader>ws" }] = { require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" } },

    -- Documentation
    [{ { "n" }, "K" }] = { vim.lsp.buf.hover, { desc = "Hover Documentation" } },
    [{ { "n" }, "<M-k>" }] = { vim.lsp.buf.signature_help, { desc = "Signature Documentation" } },

    -- Workspaces
    [{ { "n" }, "<leader>wa" }] = { vim.lsp.buf.add_workspace_folder, { desc = "Workspace Add Folder" } },
    [{ { "n" }, "<leader>wr" }] = { vim.lsp.buf.remove_workspace_folder, { desc = "Workspace Remove Folder" } },
    [{ { "n" }, "<leader>wl" }] = { function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "Workspace List Folders" } },
}

-- prefix debugging descriptions with "DEBUG: "
for _, debugging_opts in pairs(mappings.debugging) do
    debugging_opts[2].desc = "DEBUG: " .. debugging_opts[2].desc
end

-- prefix lsp descriptions with "LSP: "
for _, lsp_opts in pairs(mappings.lsp) do
    lsp_opts[2].desc = "LSP: " .. lsp_opts[2].desc
end

mappings.functions = {
    lsp = function()
        for bind, cmd in pairs(mappings.lsp) do
            vim.keymap.set(bind[1], bind[2], cmd[1], cmd[2])
        end
    end
}

return mappings
