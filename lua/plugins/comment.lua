return {
    "numToStr/Comment.nvim",
    -- keys = { "gc", "gb" },
    init = function()
        vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
        vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
    end,
    config = function()
      require("Comment").setup()
    end,
}
