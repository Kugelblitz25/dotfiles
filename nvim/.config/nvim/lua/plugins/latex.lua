-- In your LazyVim config folder, create latex.lua
return {
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      vim.g.vimtex_view_method = "zathura" -- or 'skim' for macOS
      vim.g.vimtex_view_method = "zathura"
      vim.g["vimtex_indent_enabled"] = 1
      vim.keymap.set("n", "<Leader>Lc", "<Plug>(vimtex-compile)", {})
      vim.keymap.set("n", "<Leader>Lm", "<Plug>(vimtex-toc-open)", {})
      vim.keymap.set("n", "<Leader>Ls", "<Plug>(vimtex-stop)", {})
      vim.keymap.set("n", "<Leader>Lf", "<Plug>(vimtex-clean)", {})
      vim.keymap.set("n", "<Leader>Lo", "<Plug>(vimtex-compile-output)", {})
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=0",
          "-interaction=nonstopmode",
        },
      }
      -- Cleanup auxiliary files on exit
      vim.g.vimtex_compiler_clean_paths = {
        "*.aux",
        "*.bbl",
        "*.blg",
        "*.idx",
        "*.ind",
        "*.lof",
        "*.lot",
        "*.out",
        "*.toc",
        "*.acn",
        "*.acr",
        "*.alg",
        "*.glg",
        "*.glo",
        "*.gls",
        "*.ist",
        "*.fls",
        "*.log",
        "*.fdb_latexmk",
      }
    end,
  },
}
