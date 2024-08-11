return {
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
        end,
        keys = {
            { "<C-s>", function() require("harpoon"):list():add() end, desc = "Harpoon: Add file" },
            { "<C-h>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Toggle quick menu" },

            { "<C-x>", function() require("harpoon"):list():select(1) end, desc = "Harpoon: Navigate to file 1" },
            { "<C-c>", function() require("harpoon"):list():select(2) end, desc = "Harpoon: Navigate to file 2" },
            { "<C-v>", function() require("harpoon"):list():select(3) end, desc = "Harpoon: Navigate to file 3" },
            { "<C-b>", function() require("harpoon"):list():select(4) end, desc = "Harpoon: Navigate to file 4" },

            { "<C-e>", function() require("harpoon"):list():prev() end, desc = "Harpoon: Navigate to previous buffer" },
            { "<C-t>", function() require("harpoon"):list():next() end, desc = "Harpoon: Navigate to next buffer" },
        },
    }
}

