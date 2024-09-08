return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = { mason = false },
      bufls = { mason = false },
      clangd = {
        mason = false,
        capabilities = {
          textDocument = { completion = { completionItem = { snippetSupport = true } } },
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
      },
      docker_compose_language_service = { mason = false },
      dockerls = { mason = false },
      gopls = { mason = false },
      helm_ls = { mason = false },
      lua_ls = { mason = false },
      nil_ls = { mason = false },
      pylsp = { mason = false },
      solc = { mason = false },
      yamlls = {
        mason = false,
        settings = {
          yaml = {
            schemaStore = {
              url = "https://www.schemastore.org/api/json/catalog.json",
              enable = true,
            },
            schemas = {
              kubernetes = "",
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                "ci/*.{yml,yaml}",
                ".gitlab-ci.{yml,yaml}",
              },
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json"] = {
                "*k8s*.{yml,yaml}",
                "k8s/*.{yml,yaml}",
              },
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
            },
          },
        },
      },
    },
  },
}
