> [!CAUTION]
> ROUGH DRAFT - super early in development

# gh-addressed.nvim

![image](https://github.com/dlvhdr/gh-addressed.nvim/assets/6196971/b700f784-7436-4895-a7b8-4da5571958e5)

## Requirements

Install the `gh` CLI - see the [installation instructions](https://github.com/cli/cli#installation)

## Installation

Using lazy:

```lua
return {
  "dlvhdr/gh-addressed.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>gc", "<cmd>GhReviewComments<cr>", desc = "List PR Comments" },
  },
}
```

## TODO

- [ ] Handle errors
- [ ] Prettify output with markdown parsing
