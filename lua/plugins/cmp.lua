local configFn = function()
    local cmp = require"cmp"
    local cmp_autopair = require"nvim-autopairs.completion.cmp"

    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.event:on(
        "comfirm_done",
        cmp_autopair.on_confirm_done()
    )

    cmp.setup({
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
            end,
        },
        window = {},
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
        }, {
            { name = "buffer" },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" }
        }
    })

    -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" }
        }, {
            { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
    })

    -- Set up lspconfig.
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you"ve enabled.
    local lspconfig = require("lspconfig")
    lspconfig["clangd"].setup{
        capabilities = capabilites
    }
    lspconfig["zls"].setup{
        capabilities = capabilites
    }
    lspconfig["rust_analyzer"].setup{
        capabilities = capabilites
    }

end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = configFn,
}

