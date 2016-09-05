# SwiftTheme
[![Language: Swift 2](https://img.shields.io/badge/language-swift2-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 7+](https://img.shields.io/badge/platform-iOS%207%2B-blue.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/jiecao-fm/SwiftTheme/blob/master/LICENSE)
[![Release version](https://img.shields.io/badge/release-0.1-blue.svg)]()

[前言](#前言) - [示例](#示例) - [安装](#安装) - [文档](#文档) - [贡献](#贡献)

![](https://github.com/jiecao-fm/SwiftThemeResources/blob/master/Screenshots/switch.git)

## 前言
### 缘起
项目需求，我们要为“节操精选”开发夜间模式功能。我们的需求不是简单的调整亮度或者`alpha`，而是更换为一套更深色的UI。因此所谓夜间模式其实就是特定的更换主题（换肤）功能。

如何实现呢？判断某个全局变量，然后在初始化视图控件时设置不同的背景色或者加载不同的切图文件？但是在切换主题时，已经初始化好的视图控件呢？没错，也许你也想到了通过通知让相应的视图控件修改背景色或切图。想到这里你应该也意识到了`Controller`中将充斥着注册通知、`if...else`、更新视图控件的代码，糟糕的是如果忘记了注销通知还可能引起应用崩溃。

一番思考后，我们对该任务提出了更高的要求，打造一套简单、可复用的主题框架，正如你看到的这样。

### 目标
将`SwiftTheme`打造为一款简单、功能丰富、高性能、可扩展的主题框架（换肤框架），为iOS 平台提供一个统一的主题解决方案。

## 示例


### 索引方式

让`UIView`随主题变换背景色？

```swift
view.theme_backgroundColor = ThemeColorPicker(colors: "#FFF", "#000")
```

让`UILabel`和`UIButton`随主题变换文字颜色？

```swift
label.theme_textColor = ThemeColorPicker(colors: "#000", "#FFF")
button.theme_setTitleColor(ThemeColorPicker(colors: "#000", "#FFF"), forState: .Normal)
```

让`UIImageView`随主题变换切图？

```swift
imageView.theme_image = ThemeImagePicker(names: "day", "night")
```

没问题，当你执行如下代码时，奇迹发生了！

```swift
//这里的数字代表主题参数的索引
ThemeManager.setTheme(isNight ? 1 : 0)
```

> 直接根据索引切换主题，便于快速开发。适合主题不多、无需下载主题的App。


### plist 方式
为了满足通过网络下载和安装主题包的需求，我们支持以plist 配置主题。简单讲就是在plist 中记录配置参数，比如背景色、切图文件名等，在代码中通过key 来指定相应的参数。因此，该plist 文件以及用到的资源文件就组成了一个主题包。

以下为用法示例：

```swift
view.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.backgroundColor")
imageView.theme_image = ThemeImagePicker(keyPath: "SelectedThemeCell.iconImage")
```
> 与索引方式类似，只是具体的参数值变为了间接的key 名称，正因如此赋予了它扩展的能力。


切换主题时参数为plist 名称，这里以bundle 中的plist 文件及资源文件为例，使用沙箱中的文件也是可以的。

```swift
ThemeManager.setTheme("Red", path: .MainBundle)
```

> plist 方式增加主题无需修改代码，可以无限扩展主题，因此你完全可以通过这种方式为你的用户开发下载安装主题的功能。

上面用到的plist、image 展示如下：

![](https://github.com/jiecao-fm/SwiftThemeResources/blob/master/Screenshots/1.pic.jpg)
![](https://github.com/jiecao-fm/SwiftThemeResources/blob/master/Screenshots/2.pic.jpg)

### Objective-C
完全兼容Objective-C，用法示例：

```objective-c
lbl.theme_backgroundColor = [ThemeColorPicker pickerWithColors:@[@"#FAF9F9", @"#E2E2E2"]];
```

### 主要特点
- [x] 纯Swift 编写
- [x] 兼容Objective-C
- [x] 基于runtime
- [x] 易于集成
- [x] 扩展属性以 "theme_*" 开头，便于 IDE 自动补全
- [x] 支持UIAppearance
- [x] 自动监听主题切换，更新UI
- [x] 支持通过字面量设置不同主题，通过索引进行切换
- [x] 支持使用plist设置主题，可直接通过项目资源加载，或远程下载至沙盒中加载
- [x] 主题参数配置错误时日志提示
- [x] 强类型ThemePicker
- [x] 完整的Demo


## 安装

> *Cocopods、Carthage和Framework安装基于动态链接库，动态链接库最低支持iOS8。*
> 
> **如果你的项目需要支持iOS7，必须手动拷贝源文件**

#### Cocoapods
```swift
pod 'SwiftTheme'
use_frameworks!
```

#### Carthage
```swift
github "jiecao-fm/SwiftTheme"
```

#### Framework
运行项目中名为SwiftTheme的Target，将生成的framework链到你自己的项目中

#### 源文件（iOS7）
拷贝Source文件夹下的所有文件到你的项目中

## 文档

注：`①` 索引的使用方法 `②` plist的使用方法

### *基本用法*
***

#### 设置样式

SwiftTheme为每个UI相关的属性提供了 theme_backgroundColor 、 theme_image 这种以 theme_ 开头的属性，来实现对相应属性的监听与更新，你需要设置这些属性来设置主题，例如：
```swift
①
view.theme_backgroundColor = ThemeColorPicker(colors: "#FFF", "#000")
view.theme_image = ThemeImagePicker(names: "day", "night")
②
view.theme_backgroundColor = ThemeColorPicker(keyPath: "SomeColorKeyPath")
view.theme_image = ThemeImagePicker(keyPath: "SomeImageKeyPath")
```
> 不同的属性会接收不同类型的Picker，来帮助你避免传入错误的参数，并提供更简便的设置，即便你使用了错误的Picker，编译器也会提示你。

#### 切换主题

切换主题时，所有通过 theme_ 设置的属性都会立即更新，并带有渐变动画，切换方法：
```swift
①
ThemeManager.setTheme(0) // 使用第一个主题，如 "#FFF" "day"
ThemeManager.setTheme(1) // 使用第二个主题，如 "#000" "night"
②
// 使用项目资源中的day.plist作为主题
ThemeManager.setTheme("day", path: .MainBundle)
// 使用沙盒的someURL路径中的night.plist作为主题，someURL也会作为读取资源的相对路径
ThemeManager.setTheme("night", path: .Sandbox(someURL))
// 使用传入的字典dict作为主题，someURL也会作为读取资源的相对路径
ThemeManager.setTheme(dict, path: .Sandbox(someURL))
```

#### 自定义行为

切换主题时会发送名为`ThemeUpdateNotification`的通知，你可以在任何地方观察这个通知，来实现自定义的行为：
```swift
NSNotificationCenter.defaultCenter().addObserver(self, selector: "doSomething", name: ThemeUpdateNotification, object: nil)
```
```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething) name:@"ThemeUpdateNotification" object:nil];
```

### *目前支持的属性*
***

> 子类会拥有父类的属性，例如UILabel也会拥有UIView的theme_alpha等属性，这种属性不一一列出

##### UIView
- var theme_alpha: ThemeCGFloatPicker?
- var theme_backgroundColor: ThemeColorPicker?
- var theme_tintColor: ThemeColorPicker?

##### UIApplication
- func theme_setStatusBarStyle(picker: ThemeStatusBarStylePicker, animated: Bool)

##### UIBarButtonItem
- var theme_tintColor: ThemeColorPicker?

##### UILabel
- var theme_textColor: ThemeColorPicker?
- var theme_highlightedTextColor: ThemeColorPicker?
- var theme_shadowColor: ThemeColorPicker?

##### UINavigationBar
- var theme_barTintColor: ThemeColorPicker?
- var theme_titleTextAttributes: ThemeDictionaryPicker?

##### UITabBar
- var theme_barTintColor: ThemeColorPicker?

##### UITableView
- var theme_separatorColor: ThemeColorPicker?

##### UITextField
- var theme_textColor: ThemeColorPicker?

##### UITextView
- var theme_textColor: ThemeColorPicker?

##### UIToolbar
- var theme_barTintColor: ThemeColorPicker?

##### UISwitch
- var theme_onTintColor: ThemeColorPicker?
- var theme_thumbTintColor: ThemeColorPicker?

##### UISlider
- var theme_thumbTintColor: ThemeColorPicker?
- var theme_minimumTrackTintColor: ThemeColorPicker?
- var theme_maximumTrackTintColor: ThemeColorPicker?

##### UISearchBar
- var theme_barTintColor: ThemeColorPicker?

##### UIProgressView
- var theme_progressTintColor: ThemeColorPicker?
- var theme_trackTintColor: ThemeColorPicker?

##### UIPageControl
- var theme_pageIndicatorTintColor: ThemeColorPicker?
- var theme_currentPageIndicatorTintColor: ThemeColorPicker?

##### UIImageView
- var theme_image: ThemeImagePicker?

##### UIButton
- func theme_setImage(picker: ThemeImagePicker, forState state: UIControlState)
- func theme_setBackgroundImage(picker: ThemeImagePicker, forState state: UIControlState)
- func theme_setTitleColor(picker: ThemeColorPicker, forState state: UIControlState)

##### CALayer
- var theme_borderWidth: ThemeCGFloatPicker?
- var theme_borderColor: ThemeCGColorPicker?
- var theme_shadowColor: ThemeCGColorPicker?

### *Picker*
***

#### ThemeColorPicker
```swift
// 目前支持的颜色格式有：
// "#ffcc00"		RGB十六进制 
// "#ffcc00dd"		+alpha
// "#FFF"			RGB十六进制缩写
// "#013E"			+alpha
①
ThemeColorPicker(colors: "#FFFFFF", "#000")
ThemeColorPicker.pickerWithColors(["#FFFFFF", "#000"])
②
ThemeColorPicker(keyPath: "someStringKeyPath")
ThemeColorPicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeImagePicker
```swift
①
ThemeImagePicker(names: "image1", "image2")
ThemeImagePicker.pickerWithNames(["image1", "image2"])
ThemeImagePicker(images: UIImage(named: "image1")!, UIImage(named: "image2")!)
ThemeImagePicker.pickerWithImages([UIImage(named: "image1")!, UIImage(named: "image2")!])
②
ThemeImagePicker(keyPath: "someStringKeyPath")
ThemeImagePicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeCGFloatPicker
```swift
①
ThemeCGFloatPicker(floats: 1.0, 0.7)
ThemeCGFloatPicker.pickerWithFloats([1.0, 0.7])
②
ThemeCGFloatPicker(keyPath: "someNumberKeyPath")
ThemeCGFloatPicker.pickerWithKeyPath("someNumberKeyPath")
```

#### ThemeCGColorPicker
```swift
①
ThemeCGColorPicker(colors: "#FFFFFF", "#000")
ThemeCGColorPicker.pickerWithColors(["#FFFFFF", "#000"])
②
ThemeCGColorPicker(keyPath: "someStringKeyPath")
ThemeCGColorPicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeDictionaryPicker
```swift
①
ThemeDictionaryPicker(dicts: ["key": "value"], ["key": "value"])
ThemeDictionaryPicker.pickerWithDicts([["key": "value"], ["key": "value"]])
②
// 暂时不支持从plist中读取字典
```

#### ThemeStatusBarStylePicker
```swift
①
ThemeStatusBarStylePicker(styles: .Default, .LightContent)
ThemeStatusBarStylePicker.pickerWithStyles([.Default, .LightContent])
②
// 在自定的Key中设置指定的Value，匹配字符串即可生效
// 可选的值有："UIStatusBarStyleDefault" 和 "UIStatusBarStyleLightContent"
ThemeStatusBarStylePicker(keyPath: "someStringKeyPath")
ThemeStatusBarStylePicker.pickerWithKeyPath("someStringKeyPath")
```

### *更多*

下载SwiftTheme项目，了解如何在项目中使用，其中包含两个Demo Target：

- `Demo`演示了如何使用索引进行管理，退出时保存上次使用的主题等常见需求
- `PlistDemo`演示了如何使用plist进行管理，并包含下载保存主题Zip包等功能

## 贡献

### Issue
如果你需要帮助或者遇到Bug，请[创建一个Issue](https://github.com/jiecao-fm/SwiftTheme/issues/new)

### Pull Request
期待你的贡献 :D

### Todo
- [ ] 完善文档
- [ ] 增加ThemeColorPicker支持的格式
- [ ] [Open Issue](https://github.com/jiecao-fm/SwiftTheme/issues)

### Contributors
[GeSen](https://github.com/wxxsw), [Zhoujun](https://github.com/shannonchou)


## Lisence

The MIT License (MIT)

Copyright (c) 2016 节操精选 http://jiecao.fm

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
