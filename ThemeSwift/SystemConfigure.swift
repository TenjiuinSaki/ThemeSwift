//
//  SystemConfigure.swift
//  ThemeSwift
//
//  Created by HKMac on 16/8/19.
//  Copyright © 2016年 张玉飞. All rights reserved.
//
import SwiftTheme
/// 背景色 白白白黑
let systemBackgroundColor = ThemeColorPicker(colors: "#fff", "#fff", "#fff", "#292b38")

/// 字体颜色 黑黑黑白
let systemTextColor = ThemeColorPicker(colors: "#000", "#000", "#000", "#ECF0F1")

/// 导航字体颜色 白黑白白
let systemBarTextColor = ["#FFF", "#000", "#FFF", "#FFF"]

/// 前景颜色 白黑白白
let systemTintColor = ThemeColorPicker.pickerWithColors(systemBarTextColor)

/// 导航前景颜色 红黄蓝黑
let systemBarTintColor = ThemeColorPicker(colors: "#EB4F38", "#F4C600", "#56ABE4", "#01040D")

/// 状态栏颜色 白黑白白
let statusStyle = ThemeStatusBarStylePicker(styles: .LightContent, .Default, .LightContent, .LightContent)

/// 分割线颜色 灰灰灰白
let systemSeparatorColor = ThemeColorPicker(colors: "#C6C5C5", "#C6C5C5", "#C6C5C5", "#ECF0F1")

let iconImage = ThemeImagePicker(names: "icon_theme_red", "icon_theme_yellow", "icon_theme_blue", "icon_theme_light")

let nightImage = ThemeImagePicker(names: "icon_night_dark", "icon_night_dark", "icon_night_dark", "icon_night_light")




