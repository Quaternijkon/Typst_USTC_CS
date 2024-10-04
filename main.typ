#import "config.typ": *

#codly(languages: (
  rust: (name: "Rust", icon: icon("./assets/img/brand-rust.svg"), color: RED),
))

#show: codly-init.with()//codly代码块初始化

#show: init
#show: slides.with()

#outline-slide()

//第一步
//建议使用mycontent.typ来新建你自己的内容，不要直接修改content.typ，content.typ方便你参考。
#include ".\content.typ"
//取消注释下面的行，注释上面的行
//#include ".\mycontent.typ"




