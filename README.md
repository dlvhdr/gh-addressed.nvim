> [!CAUTION]
> Early in development

# gh-addressed.nvim

Easily view and address comments left on your PR using [folke/trouble.nvim](https://github.com/folke/trouble.nvim)

![image](https://github.com/dlvhdr/gh-addressed.nvim/assets/6196971/603f46ce-5b6f-429f-ba52-88ec8b982657)


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
