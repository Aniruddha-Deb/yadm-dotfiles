return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        "markdown",
        "yaml",
        "c",
        "cpp",
        "python",
        "json",
        "lua",
        "markdown_inline",
        "javascript",
        "rust",
        "java"
      },
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = {},
      },
      autotag = {
        enable = true
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  }
}
