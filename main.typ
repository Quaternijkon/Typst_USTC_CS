#import "config.typ": *

#codly(languages: (
  rust: (name: "Rust", icon: icon("./assets/img/brand-rust.svg"), color: RED),
))

// #set table(
//   stroke: none,
//   gutter: 0.2em,
//   fill: (x, y) =>
//     if x == 0 or y == 0 { BLUE },
//   inset: (right: 1.5em),
// )

// #show table.cell: it => {
//   if it.x == 0 or it.y == 0 {
//     set text(white)
//     strong(it)
//   } else if it.body == [] {
//     // Replace empty cells with 'N/A'
//     pad(..it.inset)[_N/A_]
//   } else {
//     it
//   }
// }

#show: codly-init.with()//codly代码块初始化

#show: init
#show: slides.with()

#include ".\content1.typ"




