-- lua/plugins/blink-cmp.lua
return {
  "saghen/blink.cmp",
  optional = true,
  opts = {
    sources = {
      providers = {
        snippets = {
          score_offset = 95,
        },
      },
    },
  },
}
