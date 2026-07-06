return {
    "neovim/nvim-lspconfig",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        vim.opt.updatetime = 250

        vim.diagnostic.config {
            virtual_text = {
                format = function(diagnostic)
                    local msg = diagnostic.message
                    local max_width = 80
                    if string.len(msg) > max_width then
                        return string.sub(msg, 1, max_width) .. "..."
                    end

                    return msg
                end,
            },
            float = {
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        }

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true, }),
            callback = function()
                vim.diagnostic.open_float(nil, { focus = false, scope = "cursor", })
            end
        })

        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.textDocument.completion.completionItem.snippetSupport = false

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        local servers = {
            clangd = {},
            zls = {},
            html = {},
            ts_ls = {},
            pyright = {},
            metals = {},
            csharp_ls = {},
            fsautocomplete = {},
            c3lsp = {
                cmd = {
                    "lsp",
                    "--stdlib-path=/usr/lib/c3c/lib",
                    "--diagnostics-delay=250",
                },
                root_markers = { "project.json", "manifest.json", ".git" },
                filetypes = { "c3", "c3i" },
            },
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            },
            jdtls = {
                cmd = {
                    "jdtls",
                }
            },
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = false,
                        },
                    },
                },
            },
            lua_ls = {
                cmd = {
                    "lua-language-server",
                    "--logpath=~/.cache/lua-language-server/",
                },
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
                on_init = function(client)
                    local path = client.workspace_folders and client.workspace_folders[1].name
                    if path and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
                        return
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT",
                            path = { "lua/?.lua", "lua/?/init.lua" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    })
                end,
            },
        }

        for server_name, server_config in pairs(servers) do
            vim.lsp.config(server_name, server_config)
            vim.lsp.enable(server_name)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local bufnr = args.buf

                if client and client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format {
                                bufnr = bufnr,
                                id = client.id,
                            }
                        end,
                    })
                end
            end,
        })
    end,
}
