return {
    {
        "gruvw/strudel.nvim",
        build = "npm ci",
        config = function()
            require("strudel").setup({
                -- Headless mode: set to `true` to run the browser without launching a window
                -- (optional, default: false)
                headless = true,
            })
        end,
    },
}
