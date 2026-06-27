return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Find help" },
  },
  opts = {},
}
