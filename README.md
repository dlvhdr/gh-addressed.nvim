> [!CAUTION]
> ROUGH DRAFT - super early in development

# gh-addressed.nvim

Easily view and address comments left on your PR using [folke/trouble.nvim](https://github.com/folke/trouble.nvim)

## Requirements

Install the `gh` CLI - see the [installation instructions](https://github.com/cli/cli#installation)

## Installation

Using lazy:

```lua
return {
  "dlvhdr/gh-addressed.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/trouble.nvim",
  },
  cmd = "GhReviewComments",
  keys = {
    { "<leader>gc", "<cmd>GhReviewComments<cr>", desc = "GitHub Review Comments" },
  },
}
```

## TODO

- [ ] Handle errors
- [ ] Async
