return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.diagnostic.config({
            virtual_text = true,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = false

        vim.lsp.config("*", {
            capabilities = capabilities
        })

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
                            indent_size = "4",
                        },
                    },
                },
            },
            cmd = {
                "lua-language-server",
                "--logpath=~/.cache/lua-language-server/",
            }
        })
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("clangd")
        vim.lsp.enable("zls")
        vim.lsp.enable("html")
        vim.lsp.enable("ts_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("metals")
        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })
        vim.lsp.enable("gopls")
        vim.lsp.config("jdtls", {
            cmd = {
                "jdtls"
            }
        })
        vim.lsp.enable("jdtls")
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = false,
                    },
                },
            },
        })
        vim.lsp.enable("rust_analyzer")
        vim.lsp.enable("csharp_ls")
        vim.lsp.enable("fsautocomplete")

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = {
                "*.zig", "*.zon",
                "*.rs",
                "*.lua",
                "*.py",
                "*.c", "*.cpp", "*.h", "*.hpp",
                "*.cs", "*.fs",
                "*.js", "*.ts",
                "*.java", "*.scala",
                "*.go",
            },
            callback = function(_)
                vim.lsp.buf.format()
            end
        })
    end,
}
