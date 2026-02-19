-- -- lua/plugins/luasnip.lua
-- return {
--   "L3MON4D3/LuaSnip",
--   opts = function(_, opts)
--     local ls = require("luasnip")
--     ls.add_snippets("markdown", {
--       ls.snippet("###", {
--         ls.text_node({ "", "### " }),
--         ls.insert_node(1, "tekst"),
--         ls.text_node({ "", "", "" }),
--       }),
--     })
--     return opts
--   end,
-- }
-- ~/.config/nvim/lua/plugins/luasnip.lua
-- ~/.config/nvim/lua/plugins/luasnip.lua
-- ~/.config/nvim/lua/plugins/luasnip.lua
-- ~/.config/nvim/lua/plugins/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = function()
      local ls = require("luasnip")
      ls.setup({ enable_autosnippets = true })
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local line_begin = require("luasnip.extras.conditions.expand").line_begin

      --- Zwraca pustą linię jeśli linia powyżej nie jest pusta, w przeciwnym razie nic
      local function ensure_blank_above(_, snip)
        local row = tonumber(snip.env.TM_LINE_NUMBER)
        if row <= 1 then
          return ""
        end
        local prev_line = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
        if prev_line == nil or prev_line:match("^%s*$") then
          return ""
        end
        return { "", "" }
      end

      --- Helper: tworzy autosnippet dla markdown heading
      local function heading(trig)
        return s({ trig = trig .. " ", snippetType = "autosnippet", condition = line_begin }, {
          f(ensure_blank_above, {}),
          t(trig .. " "),
          i(1, "heading"),
          t({ "", "", "" }),
          i(0),
        })
      end

      -- Markdown headings — autosnippety, tylko na początku linii
      ls.add_snippets("markdown", {
        heading("#"),
        heading("##"),
        heading("###"),
        heading("####"),
      })

      -- -- Testowy snippet — wpisz "tst" w dowolnym pliku (do testowania integracji z blink)
      -- ls.add_snippets("all", {
      --   s("tst", {
      --     t("-- TEST LUASNIP DZIALA: "),
      --     i(1, "tutaj_tekst"),
      --     t({ "", "-- koniec testu" }),
      --   }),
      -- })
      --
      -- Tutaj możesz ładować własne snippety z katalogu:
      -- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
    end,
  },
}
