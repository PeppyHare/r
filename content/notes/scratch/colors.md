---
title: "Adding Color"
bookToc: false
---

{{< katex display >}}

{{< /katex >}}

Here is a good reference list of the pre-defined HTML colors: https://developer.mozilla.org/en-US/docs/Web/CSS/named-color


Within an equation context, KateX supports colored equation text and backgrounds with the `\textcolor{color}{text}` and `\colorbox{color}{content}` functions.

{{< katex display >}}
\textcolor{tomato}{this + equation / is = tomato}
{{< /katex >}}

{{< katex display >}}
\fcolorbox{aqua}{cadetblue}{Surrounded by a box. Enter math-mode with dollar signs $like + this$}
{{< /katex >}}