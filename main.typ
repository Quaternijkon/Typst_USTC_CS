#import "config.typ": *

#codly(languages: (
  rust: (name: "Rust", icon: icon("./assets/img/brand-rust.svg"), color: RED),
))
#show: codly-init.with()//codly代码块初始化

#show: init
#show: slides.with()

#include ".\content.typ"




