return {
    'liliwilson/warp-theme-nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('warp-theme-nvim').setup({
            theme_link = "/Users/liliwilson/.warp/themes/phenomenon.yaml"
            -- theme_link = "/Users/liliwilson/.warp/themes/hack_mit_2024.yaml"
            -- theme_link = "https://raw.githubusercontent.com/warpdotdev/themes/refs/heads/main/warp_bundled/cyber_wave.yaml"
            -- theme_link = "https://raw.githubusercontent.com/warpdotdev/themes/refs/heads/main/warp_bundled/gruvbox_dark.yaml"
        })
    end
}
