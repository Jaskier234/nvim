return {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_enable_italic = true
        vim.cmd.colorscheme('gruvbox-material')
        vim.cmd.highlight('clear', 'DiffText')
        vim.cmd.highlight('DiffText', 'guibg=#0066cc')
    end
}
