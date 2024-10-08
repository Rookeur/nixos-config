return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      tf = { "tflint" },
      yaml = { "yamllint" },
      sh = { "shellcheck" },
      proto = { "protolint" },
      python = { "pylint", "mypy" },
      json = { "jsonlint" },
      gitcommit = { "commitlint" },
      cmake = { "cmakelint" },
      -- ["*"] = { "write_good", "typos" },
    },
    linters = {
      ansible_lint = {
        condition = function(ctx)
          return vim.fs.find({ "ansible.cfg" }, { path = ctx.filename, upward = true })[1]
        end,
      },
    },
  },
}
