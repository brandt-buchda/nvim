return {
  {
    "williamboman/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = { "stylua" },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          lua = {
            -- Use stylua as the formatter
            function()
              return {
                exe = "stylua",
                args = {
                  "--search-parent-directories",
                  "--stdin-filepath",
                  vim.api.nvim_buf_get_name(0),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          },
        },
      })
      
      -- Create autocommands to format on save
      vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = "FormatAutogroup",
        pattern = { "*.lua" },
        command = "FormatWrite",
      })
    end,
  },
}

