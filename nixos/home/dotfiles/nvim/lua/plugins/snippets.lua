return {
  { "Rookeur/k8s-snippets" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
          search_paths = {
            vim.fn.stdpath("data") .. "/lazy/k8s-snippets",
          },
        },
      },
    },
  },
}
