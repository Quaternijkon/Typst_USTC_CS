# 文件说明
- `assets`: 模板资源文件
    -   `img`: 模板图片文件

- `template`: 可复用组件
    - []

- `config.typ`  : 配置文件，包括封面的信息在这里。
- `content.typ` : 只需在此处添加内容
- `lib.typ`     : 库文件，导入第三方库请在这导入
- `main.typ`    : 编译入口，导入第三方库时有可能需要把`#show`放在此处
- `theme.typ`   : 主题文件，可自行修改样式

# 使用方法
1.  vscode下载插件`Typst LSP`,`Typst Preview`,`Tinymist Typst`,`Typst Sync`。
2.  打开本项目，在`main.typ`中点击`preview`。若在`content.typ`中点击`preview`，则预览类似`markdown`的文档排版。

# 注意事项
1. 在使用时，`config.typ` 应作为顶层文件被其他文件导入，避免交叉导入。

# 自定义模板
1. 

# 组件说明 (见doc中的文档)

