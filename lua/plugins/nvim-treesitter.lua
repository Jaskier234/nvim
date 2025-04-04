return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "cpp", "bash", "git_config", "git_rebase", "gitcommit", "haskell", "lua", "make", "markdown", "ocaml", "python", "rust" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
