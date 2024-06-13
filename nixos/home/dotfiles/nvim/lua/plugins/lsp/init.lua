return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "kosayoda/nvim-lightbulb",
            opts = {
                sign = { enabled = false },
                virtual_text = {
                    enabled = true,
                    text = "",
                },
                autocmd = { enabled = true },
            },
        },
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
            opts = {
                text = {
                    spinner = "dots",
                    done = "",
                },
            },
        },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("plugins.lsp.ui").setup()

        vim.diagnostic.config({ severity_sort = true })

        local function on_attach(client, bufnr)
            require("plugins.lsp.keymaps").on_attach(bufnr)
            require("plugins.lsp.ui").on_attach(client, bufnr)
        end

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            },
            clangd = {
                capabilities = {
                    textDocument = { completion = { completionItem = { snippetSupport = false } } },
                },
            },
            pyright = {},
            texlab = {},
            bashls = {},
            dockerls = {},
            -- denols = {},
            html = {},
            -- emmet_ls = {},
            cssls = {},
            -- tailwindcss = {},
            -- vuels = {},
            sqlls = {},
            als = {},
            cmake = {},
            rust_analyzer = {},
            gopls = {},
            yamlls = {},
        }

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local lspconfig = require("lspconfig")
        for server, config in pairs(servers) do
            lspconfig[server].setup(vim.tbl_deep_extend("force", {
                on_attach = on_attach,
                capabilities = vim.deepcopy(capabilities),
            }, config))
        end

        -- local clangd_capabilities = vim.deepcopy(capabilities)
        -- clangd_capabilities.textDocument.completion.completionItem.snippetSupport =
        --     false
        -- lspconfig.clangd.setup({
        --     on_attach = on_attach,
        --     capabilities = clangd_capabilities,
        -- })
        -- lspconfig.tsserver.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     cmd = {
        --         "typescript-language-server",
        --         "--stdio",
        --         "--tsserver-path",
        --         "/nix/store/dbcrd1xdv2mawxziw9wx6l67fndb7f4x-typescript-4.8.4/bin/tsserver"
        --     }
        -- })
    end,
}
