-- TODO check options, test different capabilities

local config = {}

-- export on_attach & capabilities for custom lspconfigs

config.on_attach = function(client, bufnr)
  -- TODO utils.load_mappings("lspconfig", { buffer = bufnr })
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
    vim.keymap.set("n", "<leader>fd", function() vim.diagnostic.open_float { border = "rounded" } end)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
    vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end)

  -- if client.server_capabilities.signatureHelpProvider then
  --   require("nvchad_ui.signature").setup(client)
  -- end

  -- if not utils.load_config().ui.lsp_semantic_tokens then
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end
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

-- require('lspconfig').clangd.setup{
--   on_attach = config.on_attach,
--   flags = lsp_flags,
-- }
-- 
-- require('lspconfig').pylsp.setup{
--   on_attach = config.on_attach,
--   flags = lsp_flags,
-- }
-- 
-- require('lspconfig')['rls'].setup{
--   on_attach = config.on_attach,
--   flags = lsp_flags,
-- }
-- 
-- require('lspconfig')['hls'].setup{
--   on_attach = config.on_attach,
--   flags = lsp_flags,
-- }
-- 
-- require('lspconfig')['ocamllsp'].setup{
--   on_attach = config.on_attach,
--   flags = lsp_flags,
--   cmd = {"ocamllsp"}
-- }

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

        require('lspconfig').clangd.setup{
          on_attach = config.on_attach,
          flags = lsp_flags,
        }

        vim.g.rustaceanvim = {
          -- LSP configuration
          server = {
            on_attach = config.on_attach,
            flags = lsp_flags,
            default_settings = {
              -- rust-analyzer language server configuration
              ['rust-analyzer'] = {
              },
            },
          },
        }

    end,
}
