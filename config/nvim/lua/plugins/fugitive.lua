return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gread",
      "Gwrite",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    dependencies = {
      "tpope/vim-git",
    },
    init = function()
      vim.api.nvim_create_user_command("Gblame", "Git blame", {})
    end,
  },
}
