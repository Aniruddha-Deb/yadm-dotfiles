return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      cpp = { "clang-format" },
      c = { "clang-format" }
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },

  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- Toggleable autoformat flag (buffer-local, falls back to global)
    vim.g.autoformat_enabled = vim.g.autoformat_enabled == nil and true or vim.g.autoformat_enabled

    -- Defines :FormatDisable, :FormatEnable, :FormatToggle
    vim.api.nvim_create_user_command("FormatDisable", function(opts)
      if opts.bang then
        vim.b.autoformat_enabled = false
        print("Autoformat disabled for this buffer")
      else
        vim.g.autoformat_enabled = false
        print("Autoformat disabled globally")
      end
    end, { bang = true, desc = "Disable autoformatting (bang for buffer only)" })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.autoformat_enabled = nil
      vim.g.autoformat_enabled = true
      print("Autoformat enabled")
    end, { desc = "Enable autoformatting (resets buffer to global setting)" })

    vim.api.nvim_create_user_command("FormatToggle", function()
      local bufval = vim.b.autoformat_enabled
      local newval = not (bufval == false or (bufval == nil and not vim.g.autoformat_enabled))
      vim.b.autoformat_enabled = newval
      print("Autoformat " .. (newval and "enabled" or "disabled") .. " for this buffer")
    end, { desc = "Toggle autoformatting for this buffer" })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        local bufnr = args.buf
        -- buffer-local disable wins, then global disable
        if vim.b.autoformat_enabled == false or not vim.g.autoformat_enabled then
          return
        end
        -- strip whitespaces
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd([[%s/\s\+$//e]])
        end)
        -- finally do the format, passing your timeout
        require("conform").format({
          bufnr = bufnr,
          timeout_ms = 500, -- <-- your desired timeout in ms
          lsp_format = "fallback", -- or "prefer" / "first" / etc.
        })
      end,
    })
  end
}
