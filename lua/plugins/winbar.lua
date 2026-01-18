return {
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
        "SmiteshP/nvim-navic",
        "neovim/nvim-lspconfig",
        "onsails/lspkind-nvim",
    },
    config = function()
        local lspkind = require("lspkind")

        -- Fallback icons
        local fallback_icons = {
            File = '',
            Module = '',
            Namespace = '',
            Package = '',
            Class = '',
            Method = '',
            Property = '',
            Field = '',
            Constructor = '',
            Enum = '',
            Interface = '',
            Function = '',
            Variable = '',
            Constant = '',
            String = '',
            Number = '',
            Boolean = '',
            Array = '',
            Object = '',
            Key = '',
            Null = '',
            EnumMember = '',
            Struct = '',
            Event = '',
            Operator = '',
            TypeParameter = ''
        }

        -- First, setup nvim-navic with auto_attach and lspkind icons
        require("nvim-navic").setup({
            lsp = {
                auto_attach = true,
            },
            highlight = true,
            separator = " > ",
            depth_limit = 0,
            depth_limit_indicator = "..",
            icons = {
                File          = (lspkind.symbol_map.File or fallback_icons.File) .. ' ',
                Module        = (lspkind.symbol_map.Module or fallback_icons.Module) .. ' ',
                Namespace     = (lspkind.symbol_map.Namespace or fallback_icons.Namespace) .. ' ',
                Package       = (lspkind.symbol_map.Package or fallback_icons.Package) .. ' ',
                Class         = (lspkind.symbol_map.Class or fallback_icons.Class) .. ' ',
                Method        = (lspkind.symbol_map.Method or fallback_icons.Method) .. ' ',
                Property      = (lspkind.symbol_map.Property or fallback_icons.Property) .. ' ',
                Field         = (lspkind.symbol_map.Field or fallback_icons.Field) .. ' ',
                Constructor   = (lspkind.symbol_map.Constructor or fallback_icons.Constructor) .. ' ',
                Enum          = (lspkind.symbol_map.Enum or fallback_icons.Enum) .. ' ',
                Interface     = (lspkind.symbol_map.Interface or fallback_icons.Interface) .. ' ',
                Function      = (lspkind.symbol_map.Function or fallback_icons.Function) .. ' ',
                Variable      = (lspkind.symbol_map.Variable or fallback_icons.Variable) .. ' ',
                Constant      = (lspkind.symbol_map.Constant or fallback_icons.Constant) .. ' ',
                String        = (lspkind.symbol_map.String or fallback_icons.String) .. ' ',
                Number        = (lspkind.symbol_map.Number or fallback_icons.Number) .. ' ',
                Boolean       = (lspkind.symbol_map.Boolean or fallback_icons.Boolean) .. ' ',
                Array         = (lspkind.symbol_map.Array or fallback_icons.Array) .. ' ',
                Object        = (lspkind.symbol_map.Object or fallback_icons.Object) .. ' ',
                Key           = (lspkind.symbol_map.Key or fallback_icons.Key) .. ' ',
                Null          = (lspkind.symbol_map.Null or fallback_icons.Null) .. ' ',
                EnumMember    = (lspkind.symbol_map.EnumMember or fallback_icons.EnumMember) .. ' ',
                Struct        = (lspkind.symbol_map.Struct or fallback_icons.Struct) .. ' ',
                Event         = (lspkind.symbol_map.Event or fallback_icons.Event) .. ' ',
                Operator      = (lspkind.symbol_map.Operator or fallback_icons.Operator) .. ' ',
                TypeParameter = (lspkind.symbol_map.TypeParameter or fallback_icons.TypeParameter) .. ' ',
            }
        })

        -- Then setup breadcrumbs
        require("breadcrumbs").setup()
    end,
}
