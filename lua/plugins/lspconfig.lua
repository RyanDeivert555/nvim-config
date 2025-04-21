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
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path.."/.luarc.json") or vim.uv.fs_stat(path.."/.luarc.jsonc")) then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT"
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                })
            end,
            settings = {
                Lua = {}
            },
            cmd = {
                "lua-language-server", "--logpath=~/.cache/lua-language-server/",
            },
        }
    end,
}

