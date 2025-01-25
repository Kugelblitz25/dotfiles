return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<M-Left>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<M-Down>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<M-Up>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<M-Right>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<M-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
