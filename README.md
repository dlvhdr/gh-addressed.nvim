> [!CAUTION]
> ROUGH DRAFT - super early in development

# gh-addressed.nvim

Easily view and address comments left on your PR using [folke/trouble.nvim](https://github.com/folke/trouble.nvim)

![image](https://github.com/dlvhdr/gh-addressed.nvim/assets/6196971/4e089924-d25c-4723-8a06-6d888e6bf27a)

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
