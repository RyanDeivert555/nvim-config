return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.diagnostic.config{
            virtual_text = true,
        }
        vim.lsp.enable("lua_ls")
        vim.lsp.config("lua_ls", {
            -- TODO: stop lua_ls writing logs to protected dir
            cmd = { "lua-language-server", "--log-path=~/.cache/lua-language-server/", }
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
    end,
}

