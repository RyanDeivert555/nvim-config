return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter_start", { clear = true, }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if lang and vim.treesitter.language.add(lang) then
                    vim.treesitter.start(args.buf, lang)
                end
            end,
        })
    end,
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
    end,
}
