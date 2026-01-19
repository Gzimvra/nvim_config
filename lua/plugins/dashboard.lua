return {
    "goolord/alpha-nvim",
    lazy = false,
    --   dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            "                    zzzz                             ",
            "               xrj5TOLJIKT6hosohbbhqv                ",
            "            zp7USRTVWVVVWVRNHIY9hkmruz               ",
            "           s5169dlrpoooomjgca01RXen                  ",
            "          kW0ha50lrssppruwwwuofc034w                 ",
            "         v5bpwyyuzyxyyxqjhhhhhkkeie2g                ",
            "         najnmtpfcgjlnpqsuvuutsstokm8az             ",
            "         tmnjmkiepyzzz zvsuyz zyxunlo0iz            ",
            "         rgighpy    vootxxwzxutvvtsqkl0p            ",
            "        ymcktz        yusuyz   zwtrqnjfex           ",
            "                                  xqnjd9t           ",
            "                                    wmdbh           ",
            "                                    yqhe8z           ",
            "                                     uhfbz           ",
            "                                     ymfez           ",
            "                                 ypginrqlu           ",
            "                                yqquvxyytdiz         ",
            "                                zzzzxvtuywjoz        ",
            "                                        zzwrx        ",
            "                                          zxz        ",
        }

        -- Section Buttons
        dashboard.section.buttons.val = {
            dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"), --  = file
            dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"), --  = search/magnifier
            dashboard.button("p", "  Find project", ":Telescope projects <CR>"), --  = folder/project
            dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"), --  = recent files
            dashboard.button(
                "c",
                "  Config",
                ":Telescope find_files cwd=" .. vim.fn.stdpath("config") .. " <CR>"
            ), --  = settings/config
        }


        -- Reduce spacing / padding
        dashboard.section.buttons.opts.spacing = 1

        -- Footer: show loaded plugins / total plugins / startup time
        -- Lazy stats must be taken after lazy has finished initializing
        vim.schedule(function()
            local stats = require("lazy").stats()
            local loaded = stats.loaded
            local total = stats.count
            local startuptime = math.floor(stats.startuptime)

            local text = string.format(" Plugins loaded %d/%d in %d ms ", loaded, total, startuptime)
            local padding = 4
            local line_len = #text + padding * 3
            local line = string.rep("-", line_len)

            dashboard.section.footer.val = {
                line,
                string.rep(" ", padding) .. text .. string.rep("", padding),
                line,
            }

            dashboard.section.footer.opts = {
                position = "center",
                hl = "Type",
            }

            -- Refresh Alpha to display updated footer
            require("alpha").redraw()
        end)


        alpha.setup(dashboard.config)
    end,
}
