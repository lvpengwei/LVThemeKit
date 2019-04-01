# LVThemeKit
## 需求
App 里可以皮肤化的 UI 区域分为 3 块（App 皮肤/阅读器主题/其他），这 3 块又和黑夜模式有重叠。

 - App 皮肤区域有首页 4 个 tab bar 页面（还没有实现主题化，在规划中）
 - 阅读器主题区域主要是阅读器相关的设置和菜单页面
 - 其他指不需要主题化的区域

![](https://i.loli.net/2019/03/31/5ca0a5f084143.png)
## 第一种方案
主要思路就是给 UIKit 的 Category 增加一些属性，配置每一类主题的 key，在第一次赋值或者收到主题改变的通知时进行 apply。
  
![](https://i.loli.net/2019/03/31/5ca0a5f08618e.png)
![](https://i.loli.net/2019/03/28/5c9c9e7aec27f.png)

> qd 是黑夜模式前缀，readerTheme 是阅读器主题前缀

这种方案的问题是
- 如果要增加一类主题（比如 App 皮肤类），需要把所有之前增加的属性都 copy 一下（包括 apply 部分的代码），工作量很大。
- 如果要增加一个新的属性，需要添加多遍（前缀分别是qd/readerTheme/app）。

## 重构之后的方案

> 借助 OC 的泛型和  KVC 的一次重构

![](https://i.loli.net/2019/03/31/5ca0a5f095a1a.png)
![](https://i.loli.net/2019/03/31/5ca0ab3507209.png)
  
## 重构前后对比
![](https://ws3.sinaimg.cn/large/005BYqpggy1g1mx1031r9j31d30u07u7.jpg)

代码实现样例：[LVThemeKit](https://github.com/lvpengwei/LVThemeKit)