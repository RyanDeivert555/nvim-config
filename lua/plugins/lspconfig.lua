return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.diagnostic.config {
            virtual_text = true,
        }

        vim.lsp.enable("lua_ls")
        vim.lsp.config("lua_ls", {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name

                    if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        version = "LuaJIT",
                        path = {
                            "lua/?.lua",
                            "lua/?/init.lua",
                        },
                    },
                    workspace = {
                        checkThirdPart = false,
                        library = {
                            vim.env.VIMRUNTIME
                        },
                    },
                })
            end,
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        },
                    },
                },
            },
            cmd = {
                "lua-language-server",
                "--logpath=~/.cache/lua-language-server/",
                "--metapath=~/.cache/lua-language-server/",
            }
        })
        vim.lsp.enable("clangd")
        vim.lsp.enable("zls")
        vim.lsp.enable("html")
        -- TODO: add capabilities to all lsps?
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        vim.lsp.config("html", {
            capabilities = capabilities,
        })
        vim.lsp.enable("ts_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("rust_analyzer")
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = false,
                    },
                },
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = {
                "*.zig", "*.zon", "*.rs", "*.lua",
            },
            callback = function(_)
                vim.lsp.buf.format()
            end
        })
    end,
}
