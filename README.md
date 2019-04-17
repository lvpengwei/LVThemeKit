

# LVThemeKit

[说明](https://github.com/lvpengwei/LVThemeKit/wiki/%E8%AF%B4%E6%98%8E "说明")
  
App 多区域皮肤 UIKit Category

`LVThemeKit/ObjC` 适用于 OC 项目

`LVThemeKit/Swift` 适用于 Swift 项目

## 功能
- UIKit Category 
	- UIView
	- UIImageView
	- UILabel
	- UIButton
	- UISlider
- QuartzCore Category
	- CALayer
	- CAShapeLayer
- Resource
	- LVThemeColor
	- LVThemeImage
	- LVThemeString
	- LVThemeAttributedString
- 其他，可以很容易的扩展

## 用法
+ UIView
  
```objc
// OC
self.label.viewTK.theme.backgroundColor = [LVThemeColor background];
self.label.viewTK.other.backgroundColor = [LVThemeColor otherBackground];
```
```swift
// Swift
label.viewTK.theme.backgroundColor = LVThemeColor.background
label.viewTK.other.backgroundColor = LVThemeColor.otherBackground
```
+ UIButton
```objc
// OC
[self.button.buttonTK.theme setImage:[LVThemeImage image] forState:UIControlStateNormal];
```
```swift
// Swift
button.buttonTK.theme.setImage(LVThemeImage.image, for: .normal)
```
+ CALayer
```objc
// OC
self.layer.layerTK.theme.borderColor = [LVThemeColor background];
```
```swift
// Swift
layer.layerTK.theme.borderColor = LVthemeColor.background
```

## 配置
- `LVThemeKitConfig`
	- `generators`: 监听主题变化的通知数组，根据配置的数量生成主题数量
	- `applyProperty`: 当配置多套主题时，自定义应用顺序，默认是数组顺序
```objc
// OC
LVThemeKitConfig *conf = [[LVThemeKitConfig  alloc] init];
config.generators = @[[DayNightObserver class]];
LVThemeKit.config = conf;
```
```swift
// Swift
let conf = LVThemeKitConfig()
conf.generators = [DayNightObserver.self]
LVThemeKitConfig.config = conf
```

## 扩展
- 扩展类，参考`UIView`/`CALayer`
- 扩展属性
	- 支持 `KVC`，参考`UIView.backgroundColor`
	- 不支持 `KVC`，参考`UIButton.setTitle:forState:`
- 替换已有的类，比如`UIView.viewTK`，可以新加一个属性`UIView.x_viewTK`

## 例子
- `LVThemeKit/ObjC`
	- [MultiThemesDemo](https://github.com/lvpengwei/LVThemeKit/tree/master/Examples/MultiThemesDemo "MultiThemesDemo"): 多区域多主题，`OC`项目
	- [DayNightDemo](https://github.com/lvpengwei/LVThemeKit/tree/master/Examples/DayNightDemo "DayNightDemo"): 单主题（黑夜模式），`Swift`项目
- `LVThemeKit/Swift`
	- [DayNightDemoSwift](https://github.com/lvpengwei/LVThemeKit/tree/master/Examples/DayNightDemoSwift "DayNightDemoSwift"):单主题（黑夜模式），`Swift`项目

## 安装
### Cocoapods
`pod 'LVThemeKit/ObjC'`

或者

`pod 'LVThemeKit/Swift'`

## 类图
![](https://i.loli.net/2019/04/17/5cb6d05c376eb.jpg)