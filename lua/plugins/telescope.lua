return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        
        local telescope_config = require("telescope.config")
        telescope_config.set_defaults{
            file_ignore_patterns = {
                "%.git",
                "%.cache",
                "bin",
                "temp",
                -- specific folders
                "%.zig%-cache",
            },
        }
    end,
}

