return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			defaults = {
				winblend = 0,
				-- Default configuration for telescope goes here:
				-- config_key = value,
				mappings = {
					i = {
						-- map actions.which_key to <C-h> (default: <C-/>)
						-- actions.which_key shows the mappings for your picker,
						-- e.g. git_{create, delete, ...}_branch for the git_branches picker
						["<C-h>"] = "which_key"
					}
				}
			},
			pickers = {
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
			},
			extensions = {
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
			}
		},
		config = function(_, opts)
			require('telescope').setup(opts)
		end
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		opts = {
			extensions = {
				fzf = {
					fuzzy = true,    -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				}
			},
		},
		config = function(_, opts)
			require('telescope').setup(opts)
			--
			-- Enable telescope fzf native, if installed
			pcall(require('telescope').load_extension, 'fzf')

			-- See `:help telescope.builtin`
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

			local colors = require("catppuccin.palettes").get_palette()
			local TelescopeColor = {
				TelescopeMatching = { fg = colors.flamingo },
				TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

				TelescopePromptPrefix = { bg = colors.surface0 },
				TelescopePromptNormal = { bg = colors.surface0 },
				TelescopeResultsNormal = { bg = colors.mantle },
				TelescopePreviewNormal = { bg = colors.mantle },
				TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
				TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
				TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
				TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
				TelescopeResultsTitle = { fg = colors.mantle },
				TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
			}

			for hl, col in pairs(TelescopeColor) do
				vim.api.nvim_set_hl(0, hl, col)
			end
		end
	}
}
