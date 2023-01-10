-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- ///// \/// \\/// \///// \///////// \\\\\\/// \\\\\\\/// \\/// \\/////// \\
-- \/// \\///// /// \\/// \\\\\/// \\\\\\\\\/// \\\\\\\/// \\/// \/// \\/// \
-- \/// \\///////// \\/// \\\\\/// \\\\\\\\\/// \\\\\\\/// \\/// \///////// \
-- \/// \\/// ///// \\/// \\\\\/// \\\\\\\\\/// \\\\\\\/// \\/// \/// \\/// \
-- ///// \/// \\/// \///// \\\\/// \\\\/// \///////// \\/////// \\/// \\/// \
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

-- Load core config
require("core.abbrevs")
require("core.commands")
require("core.keymaps")
require("core.options")
require("core.signs")

-- Load plugin manager
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "tokyonight-night" },
  },
  ui = {
    icons = {
      cmd = "⌘",
      lazy = "  ",
      start = "",
    },
  },
})
