// #import "@preview/touying:0.4.2": *

#import "theme.typ": *
// #import "./theme.typ" as ustc-theme

#let s = register()

#let s = (s.methods.info)(
  self: s,
  title: [Typst template for School of Computer Science and Technology, USTC],
  subtitle: [under improvement...],
  author: [DRY],
  date: datetime.today(),
  institution: [School of Computer Science and Technology, USTC],
  logo: image("./assets/img/USTC.svg", width: 50%)
  //可以继续添加info，然后在theme.typ中添加对应的调用
)

#let (init, slides) = utils.methods(s)

#let (slide, empty-slide, title-slide, outline-slide, new-section-slide, ending-slide) = utils.slides(s)

//<>在这里添加第三方库的导入
//时间轴：https://typst.app/universe/package/timeliney
#import "@preview/timeliney:0.0.1"

//代码块：https://typst.app/universe/package/codly
#import "@preview/codly:0.2.0": *


//</>

#let icon(codepoint) = {
  box(
    height: 0.8em,
    baseline: 0.05em,
    image(codepoint)
  )
  h(0.1em)
}

#codly(languages: (
  rust: (name: "Rust", icon: icon("./assets/img/brand-rust.svg"), color: rgb("#CE412B")),
))