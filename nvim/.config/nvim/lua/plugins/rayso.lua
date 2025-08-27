return {
  "TobinPalmer/rayso.nvim",
  config = function()
    require("rayso").setup({
      base_url = "https://ray.so/", -- Ray.so URL
      open_cmd = "wslview", -- Which browser to use for opening uploads
      options = {
        background = true, -- Screenshot with background
        dark_mode = true, -- Use dark mode
        logging_path = "", -- Where to save logs of snippets
        logging_file = "rayso", -- Log filename
        logging_enabled = false, -- Enable logs
        padding = 32, -- Padding for the image
        theme = "raindrop", -- Default theme
        title = "Untitled", -- Default title for snippets
      },
    })
    vim.keymap.set("v", "<leader>rs", require("lib.create").create_snippet)
  end,
}
