return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
    config = function()
        local ts = require("nvim-treesitter")
        ts.install {
            "c", "cpp", "cmake",
            "rust",
            "c3",
            "zig",
            "java", "scala",
            "javascript", "typescript",
            "go", "gomod",
            "lua",
            "python",
            "c_sharp", "fsharp",
            "vim", "vimdoc", "vimdoc",
            "markdown", "markdown_inline",
        }
    end,
}
