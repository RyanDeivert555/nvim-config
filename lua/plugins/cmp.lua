local configFn = function()
    local cmp = require("cmp")

    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
    )

    cmp.setup({
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body)
            end,
        },
        window = {},
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
        }, {
            { name = "buffer" },
        })
    })

    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            {
                name = "buffer",
            }
        }
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" }
        }, {
            { name = "cmdline" }
        }),
        matching = {
            disallow_symbol_nonprefix_matching = false,
        },
    })
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = configFn,
}
