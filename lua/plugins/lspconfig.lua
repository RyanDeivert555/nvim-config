return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig");
        lspconfig.clangd.setup{}
        lspconfig.zls.setup{}
        lspconfig.rust_analyzer.setup{
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true,
                    },
                },
            },
        }
    end,
} 

