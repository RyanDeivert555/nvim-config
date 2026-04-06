return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

        local telescope = require("telescope");
        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules/",
                    ".git/",
                    "build/",
                    "external/",
                    "zig-out/",
                    "bin/",
                    "obj/",
                }
            }
        })
    end,
}
