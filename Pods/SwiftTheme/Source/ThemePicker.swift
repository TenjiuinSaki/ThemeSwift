//
//  ThemePicker.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/25.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

public class ThemePicker: NSObject, NSCopying {
    
    public typealias ValueType = () -> AnyObject?
    
    var value: ValueType
    
    required public init(v: ValueType) {
        value = v
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        return self.dynamicType.init(v: value)
    }
    
}

public class ThemeColorPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { return ThemeManager.colorForKeyPath(keyPath) })
    }

    public convenience init(colors: String...) {
        self.init(v: { return ThemeManager.colorForArray(colors) })
    }
    
    public class func pickerWithKeyPath(keyPath: String) -> ThemeColorPicker {
        return ThemeColorPicker(keyPath: keyPath)
    }
    
    public class func pickerWithColors(colors: [String]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { return ThemeManager.colorForArray(colors) })
    }
    
}

public class ThemeImagePicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { return ThemeManager.imageForKeyPath(keyPath) })
    }
    
    public convenience init(names: String...) {
        self.init(v: { return ThemeManager.imageForArray(names) })
    }
    
    public convenience init(images: UIImage...) {
        self.init(v: { return ThemeManager.elementForArray(images) })
    }
    
    public class func pickerWithKeyPath(keyPath: String) -> ThemeImagePicker {
        return ThemeImagePicker(keyPath: keyPath)
    }
    
    public class func pickerWithNames(names: [String]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { return ThemeManager.imageForArray(names) })
    }
    
    public class func pickerWithImages(images: [UIImage]) -> ThemeImagePicker {
        return ThemeImagePicker(v: { return ThemeManager.elementForArray(images) })
    }
    
}

public class ThemeCGFloatPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { return CGFloat(ThemeManager.numberForKeyPath(keyPath) ?? 0) })
    }
    
    public convenience init(floats: CGFloat...) {
        self.init(v: { return ThemeManager.elementForArray(floats) })
    }
    
    public class func pickerWithKeyPath(keyPath: String) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(keyPath: keyPath)
    }
    
    public class func pickerWithFloats(floats: [CGFloat]) -> ThemeCGFloatPicker {
        return ThemeCGFloatPicker(v: { return ThemeManager.elementForArray(floats) })
    }
    
}

public class ThemeCGColorPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { return ThemeManager.colorForKeyPath(keyPath)?.CGColor })
    }
    
    public convenience init(colors: String...) {
        self.init(v: { return ThemeManager.colorForArray(colors)?.CGColor })
    }
    
    public class func pickerWithKeyPath(keyPath: String) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(keyPath: keyPath)
    }
    
    public class func pickerWithColors(colors: [String]) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(v: { return ThemeManager.colorForArray(colors)?.CGColor })
    }
    
}

public class ThemeDictionaryPicker: ThemePicker {
    
    public convenience init(dicts: [String: AnyObject]...) {
        self.init(v: { return ThemeManager.elementForArray(dicts) })
    }
    
    public class func pickerWithDicts(dicts: [[String: AnyObject]]) -> ThemeDictionaryPicker {
        return ThemeDictionaryPicker(v: { return ThemeManager.elementForArray(dicts) })
    }
    
}

public class ThemeStatusBarStylePicker: ThemePicker {
    
    var styles: [UIStatusBarStyle]?
    var animated = true
    
    public convenience init(keyPath: String) {
        self.init(v: { return ThemeManager.stringForKeyPath(keyPath) })
    }
    
    public convenience init(styles: UIStatusBarStyle...) {
        self.init(v: { return 0 })
        self.styles = styles
    }
    
    public class func pickerWithKeyPath(keyPath: String) -> ThemeStatusBarStylePicker {
        return ThemeStatusBarStylePicker(keyPath: keyPath)
    }
    
    public class func pickerWithStyles(styles: [UIStatusBarStyle]) -> ThemeStatusBarStylePicker {
        let picker = ThemeStatusBarStylePicker(v: { return 0 })
        picker.styles = styles
        return picker
    }
    
    func currentStyle(value: AnyObject?) -> UIStatusBarStyle {
        if let styles = styles {
            if styles.indices ~= ThemeManager.currentThemeIndex {
                return styles[ThemeManager.currentThemeIndex]
            }
        }
        if let styleString = value as? String {
            switch styleString {
            case "UIStatusBarStyleDefault"      : return .Default
            case "UIStatusBarStyleLightContent" : return .LightContent
            default: break
            }
        }
        return .Default
    }
    
}

class ThemeStatePicker: ThemePicker {
    
    typealias ValuesType = [UInt: ThemePicker]
    
    var values = ValuesType()
    
    convenience init(picker: ThemePicker, withState state: UIControlState) {
        self.init(v: { return 0 })
        self.setPicker(picker, forState: state)
    }
    
    class func pickerWithPicker(picker: ThemePicker, andState state: UIControlState) -> ThemeStatePicker {
        return ThemeStatePicker(picker: picker, withState: state)
    }
    
    func setPicker(picker: ThemePicker, forState state: UIControlState) -> Self {
        values[state.rawValue] = picker
        return self
    }
}
