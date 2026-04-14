local is_vscode = vim.g.vscode ~= nil

return {
    {
        "goolord/alpha-nvim",
        cond = not is_vscode,
        lazy = false,
        dependencies = { "nvim-mini/mini.nvim" },
        config = function()
            local startify = require("alpha.themes.startify")
            local config_path = vim.fn.stdpath("config")
            local dotfiles_path = vim.fs.normalize(config_path .. "/../..")

            startify.file_icons.provider = "mini"
            startify.mru_sections = { "mru_cwd", "mru" }
            startify.section.header.val = {
                "",
                "                                                    ▟▙            ",
                "                                                    ▝▘            ",
                "            ██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖",
                "            ██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██",
                "            ██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██",
                "            ██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██",
                "            ▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀",
                "",
            }

            startify.section.top_buttons.val = {
                startify.button("e", "New file", "<cmd>ene <CR>"),
                startify.button("ch", "Health Check", "<cmd>checkhealth<CR>"),
                startify.button("ps", "Plugin Status", "<cmd>Lazy<CR>"),
                startify.button("pu", "Update Plugins", "<cmd>Lazy sync<CR>"),
                startify.button("uc", "Tool Manager", "<cmd>Mason<CR>"),
                startify.button("h", "Help", "<cmd>help<CR>"),
            }

            local bookmarks = {
                type = "group",
                val = {
                    { type = "padding", val = 1 },
                    { type = "text",    val = "Bookmarks", opts = { hl = "SpecialComment", shrink_margin = false } },
                    { type = "padding", val = 1 },
                    startify.file_button(config_path, "v", "~/.config/nvim", true),
                    startify.file_button(dotfiles_path, "d", "~/.dotfiles", true),
                },
                opts = { shrink_margin = false },
            }

            startify.config.layout = {
                { type = "padding", val = 1 },
                startify.section.header,
                { type = "padding", val = 2 },
                startify.section.top_buttons,
                {
                    type = "group",
                    val = function()
                        local result = {}
                        for _, name in ipairs(startify.mru_sections) do
                            if startify.section[name] then
                                table.insert(result, startify.section[name])
                            end
                        end
                        return result
                    end,
                },
                bookmarks,
                { type = "padding", val = 1 },
                startify.section.bottom_buttons,
                startify.section.footer,
            }

            startify.config.opts = startify.config.opts or {}
            startify.config.opts.autostart = false

            require("alpha").setup(startify.config)
        end,
        keys = {
            { "<F6>", "<Cmd>Alpha<CR>", desc = "Start screen" },
        },
    },
}
