return {
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
    config = function()
        local lspconfig = require("lspconfig")
        local neodev = require("neodev")
        neodev.setup{}
        lspconfig.clangd.setup{}
        lspconfig.zls.setup{}
        lspconfig.ts_ls.setup{}
        -- for html autocomplete
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        lspconfig.html.setup{
            capabilities = capabilities
        }
        lspconfig.pyright.setup{}
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
        lspconfig.lua_ls.setup{
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    workspace = {
                        library = {
                            vim.api.nvim_get_runtime_file("", true),
                        },
                        checkThirdParty = false,
                    },
                },
            },
            cmd = {
                "lua-language-server",
                "--logpath=~/.cache/lua-language-server/",
            },
        }
    end,
}

