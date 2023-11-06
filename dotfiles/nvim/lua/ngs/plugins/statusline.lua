local nonicons = require("nvim-nonicons")
local git = require("ngs.util")

local separators = { a = "", b = "", y = "", z = "" }

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = vim.g.colorscheme or "auto",
      component_separators = "",
      section_separators = "",
    },
    sections = {
      lualine_a = {
        {
          "mode",
          color = { gui = "bold" },
          separator = { left = separators.a },
        },
      },
      lualine_b = {
        {
          "branch",
          fmt = function(branch)
            return git.format_branch(branch)
          end,
          icon = nonicons.get("git-branch"),
          separator = { right = separators.b },
        },
      },
      lualine_c = {
        {
          "filename",
          symbols = { modified = "", readonly = "" },
        },
        "diff",
        {
          "encoding",
          cond = function()
            return vim.o.fileencoding ~= "utf-8"
          end,
        },
        {
          "fileformat",
          cond = function()
            return vim.o.fileformat ~= "unix"
          end,
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
        },
        "filetype",
      },

      lualine_y = {
        {
          "progress",
          separator = { left = separators.y },
        },
      },
      lualine_z = {
        {
          "location",
          separator = { right = separators.z },
        },
      }
    },
  }
}