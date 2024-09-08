return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        json = { "jq" },
        lua = { "stylua" },
        nix = { "nixpkgs_fmt" },
        python = { "black", "isort" },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        rust = { "rustfmt" },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.remove(opts.ensure_installed)
      table.remove(opts.ensure_installed)
    end,
  },
}
