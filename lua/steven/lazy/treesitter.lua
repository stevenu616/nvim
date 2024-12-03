return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vimdoc",
                "c",
                "lua",
            },

            sync_install = false,

            auto_install = true,

            indent = {
                enable = true,
            },

            highlight = {
                enable = true,

                additional_vim_regex_highlighting = { "markdown" },
            },
        })

        vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
        vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Special"})
    end,
}
