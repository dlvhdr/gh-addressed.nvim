> [!CAUTION]
> ROUGH DRAFT - super early in development

# gh-addressed.nvim

Easily view and address comments left on your PR using [folke/trouble.nvim](https://github.com/folke/trouble.nvim)

![Capture-2024-02-05-233121](https://github.com/dlvhdr/gh-addressed.nvim/assets/6196971/3cdc9949-3cc0-45a6-9301-f72aeb8c88de)

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
