local is_vscode = vim.g.vscode ~= nil

local function setup_completion()
    require("blink.cmp").setup({
        keymap = {
            preset = "enter",
            ["<CR>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "fallback",
            },
            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = {
                    border = "rounded",
                },
            },
            menu = {
                auto_show = true,
                border = "rounded",
                draw = {
                    padding = { 0, 1 },
                    columns = {
                        { "kind_icon" },
                        { "label",    "label_description", gap = 2 },
                    },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                return (ctx.kind_icon or "") .. " "
                            end,
                        },
                    },
                },
            },
        },
        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "tmux", "buffer" },
            per_filetype = {
                gitcommit = { inherit_defaults = true, "conventional_commits" },
                markdown = { inherit_defaults = true, "git", "dictionary", "thesaurus" },
                text = { inherit_defaults = true, "dictionary", "thesaurus" },
            },
            providers = {
                conventional_commits = {
                    module = "blink-cmp-conventional-commits",
                    name = "Conventional Commits",
                    score_offset = 8,
                },
                dictionary = {
                    module = "blink-cmp-words.dictionary",
                    name = "Words",
                    min_keyword_length = 3,
                    score_offset = -5,
                },
                thesaurus = {
                    module = "blink-cmp-words.thesaurus",
                    name = "Synonyms",
                    min_keyword_length = 3,
                    score_offset = -6,
                },
                tmux = {
                    module = "blink-cmp-tmux",
                    name = "tmux",
                    enabled = function()
                        return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
                    end,
                    score_offset = -4,
                    opts = {
                        panes = "session",
                        capture_history = true,
                    },
                },
            },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },
    })
end

local function setup_formatting()
    require("conform").setup({
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            css = { "prettier" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier" },
            python = { "black" },
            sh = { "shfmt" },
            typescript = { "prettier" },
            yaml = { "prettier" },
        },
    })

    vim.api.nvim_create_user_command("Format", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
    end, { desc = "Format current buffer" })
end

local function setup_lsp()
    local function map_lsp(bufnr)
        local map = vim.keymap.set

        map("n", "K", function()
            vim.lsp.buf.hover({
                border = "rounded",
                title = "Hover",
            })
        end, { buffer = bufnr, silent = true, desc = "Hover" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, silent = true, desc = "Rename" })
        map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, silent = true, desc = "Code action" })
        map("n", "<leader>jd", vim.lsp.buf.definition, { buffer = bufnr, silent = true, desc = "Definition" })
        map("n", "<leader>jy", vim.lsp.buf.type_definition, { buffer = bufnr, silent = true, desc = "Type definition" })
        map("n", "<leader>ji", vim.lsp.buf.implementation, { buffer = bufnr, silent = true, desc = "Implementation" })
        map("n", "<leader>jr", vim.lsp.buf.references, { buffer = bufnr, silent = true, desc = "References" })
        map("n", "[g", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, { buffer = bufnr, silent = true, desc = "Previous diagnostic" })
        map("n", "]g", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, { buffer = bufnr, silent = true, desc = "Next diagnostic" })
    end

    local function organize_imports()
        vim.lsp.buf.code_action({
            apply = true,
            context = {
                only = { "source.organizeImports" },
                diagnostics = {},
            },
        })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_blink, blink = pcall(require, "blink.cmp")
    if ok_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
    end

    local signs = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN] = "⚠",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "ஐ",
    }

    vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = true,
        virtual_text = {
            prefix = " ❯❯❯ ",
            source = false,
        },
        signs = {
            text = signs,
        },
        float = {
            border = "rounded",
            source = "if_many",
        },
    })

    local lsp_group = vim.api.nvim_create_augroup("migration-native-lsp", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,
        callback = function(args)
            map_lsp(args.buf)
        end,
    })

    vim.api.nvim_create_user_command("OR", organize_imports, { desc = "Organize imports" })

    local servers = {
        bashls = {},
        clangd = {},
        cssls = {},
        html = {},
        jsonls = {},
        lemminx = {},
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        },
        pyright = {},
        ts_ls = {},
        yamlls = {},
    }

    for server, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
    end
end

return {
    {
        "williamboman/mason.nvim",
        cond = not is_vscode,
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = {},
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        cond = not is_vscode,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = {
            ensure_installed = {
                "bash-language-server",
                "black",
                "clang-format",
                "clangd",
                "css-lsp",
                "html-lsp",
                "json-lsp",
                "lemminx",
                "lua-language-server",
                "prettier",
                "pyright",
                "shfmt",
                "stylua",
                "typescript-language-server",
                "yaml-language-server",
            },
            run_on_start = true,
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cond = not is_vscode,
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "bashls",
                "clangd",
                "cssls",
                "html",
                "jsonls",
                "lemminx",
                "lua_ls",
                "pyright",
                "ts_ls",
                "yamlls",
            },
            automatic_enable = false,
        },
    },
    {
        "neovim/nvim-lspconfig",
        cond = not is_vscode,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = setup_lsp,
    },
    {
        "Saghen/blink.cmp",
        cond = not is_vscode,
        version = "1.*",
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "archie-judd/blink-cmp-words",
            "disrupted/blink-cmp-conventional-commits",
            "mgalliou/blink-cmp-tmux",
        },
        config = setup_completion,
    },
    {
        "stevearc/conform.nvim",
        cond = not is_vscode,
        lazy = false,
        config = setup_formatting,
    },
}
