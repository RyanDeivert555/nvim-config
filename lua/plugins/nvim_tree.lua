return {
    "nvim-tree/nvim-tree.lua",
    version = "1.6.0",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local api = require("nvim-tree.api")

        require("nvim-tree").setup{}
        vim.keymap.set("n", "<leader>ft", api.tree.toggle, {})
    end,
}

