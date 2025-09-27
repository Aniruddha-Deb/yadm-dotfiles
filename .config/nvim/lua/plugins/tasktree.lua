return {
  {
    "neov5/tasktree.nvim",
    ft = { "tasktree" },
    config = function()
      require("tasktree").setup()
    end,
  }
}
