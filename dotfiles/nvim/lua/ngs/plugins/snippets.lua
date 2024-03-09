-- ===================================================================
--  Text Snippets
-- ===================================================================

return {
  -- =================================================================
  --  LuaSnip
  -- -----------------------------------------------------------------
  --  https://github.com/L3MON4D3/LuaSnip
  --  Lua-based snippet engine
  -- -----------------------------------------------------------------
  "L3MON4D3/LuaSnip",

  build = "make install_jsregexp",

  config = function(_, opts)
    local ls = require("luasnip")

    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    vim.keymap.set({ "i", "s" }, "<C-o>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end)

    vim.keymap.set({ "i", "s" }, "<C-i>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end)

    vim.keymap.set("i", "<C-p>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    for lang, snippets in pairs(opts.snippets or {}) do
      ls.add_snippets(lang, snippets)
    end
  end,
}
