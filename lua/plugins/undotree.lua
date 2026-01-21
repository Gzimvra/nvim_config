return {
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        config = function()
            --Optional UI tweaks
            vim.g.undotree_WindowLayout = 1
            -- vim.g.undotree_DiffAutoOpen = 0
            vim.g.undotree_SplitWidth = 35
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_HelpLine = 0
        end,
    },
}
