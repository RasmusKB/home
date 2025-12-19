local ok, markview = pcall(require, "markview")
if not ok then
    vim.notify("markview.nvim is not installed!", vim.log.levels.WARN)
    return
end

markview.setup({
    -- 1. MODES
    -- These are the modes where the fancy rendering is active.
    -- Usually, you want it active in Normal mode.
    modes = { "n", "no", "c" },

    -- 2. HYBRID MODES (Crucial for editing)
    -- If the cursor is on a line, show the raw markdown symbols.
    -- If the cursor moves away, render the fancy preview.
    hybrid_modes = { "n" },

    -- 3. CALLBACKS
    -- Ensure 'conceallevel' is set to 2. Without this, the plugin
    -- cannot hide the raw markdown symbols (*, #, etc.) behind the rendered UI.
    callbacks = {
        on_enable = function (_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = "nc"
        end
    },

    -- 4. COMPONENT CUSTOMIZATION
    -- The defaults are very good, but you can tweak specific elements here.
    markdown = {
        headings = {
            shift_width = 0, -- Amount of space to indent headings

            -- Example: Customizing Heading 1 look
            heading_1 = {
                style = "label", -- Options: "simple", "label", "icon"
                icon = "󰉫 ",
                hl = "MarkviewHeading1" -- The highlight group
            },
            heading_2 = { style = "label", icon = "󰉬 " },
            heading_3 = { style = "label", icon = "󰉭 " },
        },

        code_blocks = {
            style = "language", -- Use language-specific colors
            pad_amount = 1,     -- Add padding inside the block
            language_names = {
                ["lua"] = "Lua",
                ["rust"] = "Rust",
                ["js"] = "JavaScript"
            }
        },

        tables = {
            block_length = 3, -- Minimum width of a cell
            use_virt_lines = true,
        },

        checkboxes = {
            enable = true,
            checked = { icon = "✔" },
            unchecked = { icon = "✘" },
        }
    }
})
