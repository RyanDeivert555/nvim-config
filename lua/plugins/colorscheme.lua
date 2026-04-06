return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_background = "medium"
    end,
    config = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("gruvbox-material")
    end,
}
