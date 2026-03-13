return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  version = "v2.*",
  -- version = "v2.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    end,
  },
  build = "make install_jsregexp",

  -- stylua: ignore
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })
    local s = luasnip.snippet
    local t = luasnip.text_node
    local i = luasnip.insert_node
    local d = luasnip.dynamic_node
    local sn = luasnip.snippet_node
    luasnip.add_snippets("all", {
      s("ternary", {
        i(1, "cond"),
        t(" ? "),
        i(2, "then"),
        t(" : "),
        i(3, "else"),
      }),
      s("aaa", { t("console.log("), i(1, ""), t(")") }),
      s("rc", {
        t("export type "),
        i(1),
        t("Props = {}"),
        t({ "", "export function " }),
        d(2, function(args)
          -- the returned snippetNode doesn't need a position; it's inserted
          -- "inside" the dynamicNode.
          return sn(nil, {
            -- jump-indices are local to each snippetNode, so restart at 1.
            i(1, args[1]),
          })
        end, { 1 }),
        t("(){return null}"),
      }),
    })
  end,
}
