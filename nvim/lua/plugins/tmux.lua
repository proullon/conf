--- lua/plugins/tmux.conf
return {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        init = function()
            -- Disable default mappings if you want to control everything yourself
            -- Set to 1 ONLY if you want to define your own keymaps
            -- vim.g.tmux_navigator_no_mappings = 1
        end,
    },
}
