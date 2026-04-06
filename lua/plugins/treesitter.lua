return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        ts.install {
            "c", "cpp", "cmake",
            "rust",
            "zig",
            "java", "scala",
            "javascript", "typescript",
            "go", "gomod",
            "lua",
            "python",
            "c_sharp", "fsharp",
            "vim", "vimdoc",
            "markdown", "markdown_inline",
        }
    end
}
