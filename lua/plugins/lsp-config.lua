-- TODO check options, test different capabilities that may be useful
--   - incoming/outgoing calls

local config = {}

-- export on_attach & capabilities for custom lspconfigs

config.on_attach = function(client, bufnr)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
    vim.keymap.set("n", "<leader>fd", function() vim.diagnostic.open_float { border = "rounded" } end)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
    vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end)
    vim.keymap.set("n", "<leader>ra", function() vim.lsp.buf.rename() end)
end

config.capabilities = vim.lsp.protocol.make_client_capabilities()

config.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = false,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

return {
    "neovim/nvim-lspconfig",
    config = function()
        require("lspconfig").lua_ls.setup { on_attach = config.on_attach,
            capabilities = config.capabilities,

            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                            [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
                            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        }

        require('lspconfig').clangd.setup {
            on_attach = function()
                config.on_attach()

                -- Add clangd specific mapping
                vim.keymap.set("n", "<leader>hh", ":ClangdSwitchSourceHeader <CR>")
            end,
            cmd = {"docker", "run", "-i", "-w=/home/artur/onyx-engine", "--volume=/home/artur/onyx-engine/:/home/artur/onyx-engine", "registry.gitlab.com/onyxtms/onyx-engine/main", "clangd"},
            -- cmd = {"docker run -it registry.gitlab.com/onyxtms/onyx-engine/main clangd"},
        }


        vim.g.rustaceanvim = {
            -- LSP configuration
            server = {
                on_attach = config.on_attach,
                default_settings = {
                    -- rust-analyzer language server configuration
                    ['rust-analyzer'] = {
                    },
                },
            },
        }
    end,
}
