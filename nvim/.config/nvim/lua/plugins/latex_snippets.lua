return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local i = ls.insert_node
      local fmt = require("luasnip.extras.fmt").fmt

      ls.add_snippets("tex", {
        s(
          "ArticleK",
          fmt(
            [[
          \documentclass[12pt,a4paper]{{article}}
          \usepackage{{amsmath}}
          \usepackage{{amsfonts}}
          \usepackage{{amssymb}}
          \usepackage{{graphicx}}
          \usepackage{{hyperref}}
          \usepackage[margin=2cm]{{geometry}}

          \title{{{}}}
          \author{{Kugelblitz}}
          \date{{\today}}

          \begin{{document}}

          \maketitle
          \tableofcontents
          \section{{Introduction}}
          {}

          \end{{document}}
        ]],
            {
              i(1, "Title"),
              i(2, "%Content"),
            }
          )
        ),
        s(
          "ArticleV",
          fmt(
            [[
          \documentclass[12pt,a4paper]{{article}}
          \usepackage{{amsmath}}
          \usepackage{{amsfonts}}
          \usepackage{{amssymb}}
          \usepackage{{graphicx}}
          \usepackage{{hyperref}}
          \usepackage[margin=2cm]{{geometry}}

          \title{{{}}}
          \author{{Vighnesh Nayak}}
          \date{{\today}}

          \begin{{document}}

          \maketitle
          \tableofcontents
          \section{{Introduction}}
          {}

          \end{{document}}
        ]],
            {
              i(1, "Title"),
              i(2, "%Content"),
            }
          )
        ),
        s(
          "ArticleB",
          fmt(
            [[
          \documentclass[12pt,a4paper]{{article}}
          \usepackage{{amsmath}}
          \usepackage{{amsfonts}}
          \usepackage{{amssymb}}
          \usepackage{{graphicx}}
          \usepackage{{hyperref}}
          \usepackage[margin=2cm]{{geometry}}

          \title{{{}}}
          \author{{Vighnesh Nayak}}
          \date{{\today}}

          \begin{{document}}

          \maketitle
           \begin{{figure}}[htbp]
            \centering
            \includegraphics[width=0.6\linewidth]{{\string~/logo.png}}
          \end{{figure}}
          \newpage
          \tableofcontents
          \newpage
          \section{{Introduction}}
          {}

          \end{{document}}
        ]],
            {
              i(1, "Title"),
              i(2, "%Content"),
            }
          )
        ),
        s(
          "logo",
          fmt(
            [[
          \begin{{figure}}[htbp]
            \centering
            \includegraphics[width=0.6\linewidth]{{\string~/logo.png}}
          \end{{figure}}
        ]],
            {}
          )
        ),
        s(
          "figure2",
          fmt(
            [[
          \begin{{figure}}[htbp]
              \centering
              \begin{{subfigure}}[b]{{0.48\textwidth}}
                  \centering
                  \includegraphics[width=\textwidth]{{{}}}
                  \caption{{{}}}
                  \label{{fig:{}}}
              \end{{subfigure}}
              \hfill
              \begin{{subfigure}}[b]{{0.48\textwidth}}
                  \centering
                  \includegraphics[width=\textwidth]{{{}}}
                  \caption{{{}}}
                  \label{{fig:{}}}
              \end{{subfigure}}
              \caption{{{}}}
              \label{{fig:{}}}
          \end{{figure}}
        ]],
            {
              i(1, "images/"),
              i(2, "Caption"),
              i(3, "fig1"),
              i(4, "images/"),
              i(5, "Caption"),
              i(6, "fig2"),
              i(7, "Combined Caption"),
              i(8, "fig-set"),
            }
          )
        ),
      })
    end,
  },
}
