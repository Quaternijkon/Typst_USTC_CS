#import "@preview/suiji:0.3.0": *

#let (
  BLUE,
  GREEN,
  YELLOW,
  RED,
)=(
  rgb("#4285f4"),
  rgb("#34a853"),
  rgb("#fbbc05"),
  rgb("#ea4335"),
)

#let BlueText(_text)={
  set text(fill: BLUE)
  [#_text]
}

#let GreenText(_text)={
  set text(fill: GREEN)
  [#_text]
}

#let YellowText(_text)={
  set text(fill: YELLOW)
  [#_text]
}

#let RedText(_text)={
  set text(fill: RED)
  [#_text]
}

#let Colorful(_text)={
  let colors = (
     rgb("#4285F4"),
     rgb("#34A853"),
     rgb("#FBBC05"),
     rgb("#EA4335"),
  )

  let i=1;
  let rng = gen-rng(_text.text.len());
  let index_pre = integers(rng, low: 0, high: 4, size: none, endpoint: false).at(1);


  for c in _text.text{
    let rng = gen-rng(i);
    let index_cur = integers(rng, low: 0, high: 4, size: none, endpoint: false).at(1);
    let cnt=100;
    while index_cur == index_pre and cnt>0{
      let rng = gen-rng(cnt);
      index_cur = integers(rng, low: 0, high: 4, size: none, endpoint: false).at(1);
      cnt -= 1;
    }
    let color = colors.at(index_cur);
    set text(fill: color)
    [#c]
    index_pre = index_cur;
    i += 1;

  }
}