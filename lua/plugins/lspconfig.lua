return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
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
            cmd = {
                "lua-language-server", "--logpath=~/.cache/lua-language-server/", "--configpath=~/.config/nvim/luarc.json",
            },
            filetypes = {"lua"},
            root_markers = {
                ".luarc.json", ".luarc.jsonc",
            },
        }
    end,
}

