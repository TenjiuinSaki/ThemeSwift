//
//  NSObject+Theme.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

extension NSObject {
    
    public typealias ThemePickers = [String: ThemePicker]
    
    public var themePickers: ThemePickers {
        get {
            if let themePickers = objc_getAssociatedObject(self, &themePickersKey) as? ThemePickers {
                return themePickers
            }
            let initValue = ThemePickers()
            objc_setAssociatedObject(self, &themePickersKey, initValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return initValue
        }
        set {
            objc_setAssociatedObject(self, &themePickersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            _removeThemeNotification()
            if newValue.isEmpty == false { _setupThemeNotification() }
        }
    }
    
    func performThemePicker(selector: String, picker: ThemePicker?) {
        let sel = Selector(selector)
        let methodSignature = self.methodForSelector(sel)
        guard respondsToSelector(sel)     else { return }
        guard let value = picker?.value() else { return }
        
        if let statePicker = picker as? ThemeStatePicker {
            let setState = unsafeBitCast(methodSignature, setValueForStateIMP.self)
            statePicker.values.forEach { setState(self, sel, $1.value()!, UIControlState(rawValue: $0)) }
        }
            
        else if let statusBarStylePicker = picker as? ThemeStatusBarStylePicker {
            let setStatusBarStyle = unsafeBitCast(methodSignature, setStatusBarStyleValueIMP.self)
            setStatusBarStyle(self, sel, statusBarStylePicker.currentStyle(value), statusBarStylePicker.animated)
        }
        
        else if picker is ThemeCGFloatPicker {
            let setCGFloat = unsafeBitCast(methodSignature, setCGFloatValueIMP.self)
            setCGFloat(self, sel, value as! CGFloat)
        }
        
        else if picker is ThemeCGColorPicker {
            let setCGColor = unsafeBitCast(methodSignature, setCGColorValueIMP.self)
            setCGColor(self, sel, value as! CGColor)
        }
        
        else { performSelector(sel, withObject: value) }
    }
    
    private typealias setCGColorValueIMP        = @convention(c) (NSObject, Selector, CGColor) -> Void
    private typealias setCGFloatValueIMP        = @convention(c) (NSObject, Selector, CGFloat) -> Void
    private typealias setValueForStateIMP       = @convention(c) (NSObject, Selector, AnyObject, UIControlState) -> Void
    private typealias setStatusBarStyleValueIMP = @convention(c) (NSObject, Selector, UIStatusBarStyle, Bool) -> Void
    
}

extension NSObject {
    
    private func _setupThemeNotification() {
        if #available(iOS 9.0, *) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(_updateTheme), name: ThemeUpdateNotification, object: nil)
        } else {
            NSNotificationCenter.defaultCenter().addObserverForName(ThemeUpdateNotification, object: nil, queue: nil, usingBlock: { [weak self] notification in self?._updateTheme() })
        }
    }
    
    private func _removeThemeNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ThemeUpdateNotification, object: nil)
    }
    
    @objc private func _updateTheme() {
        themePickers.forEach { selector, picker in
            UIView.animateWithDuration(ThemeManager.animationDuration) {
                self.performThemePicker(selector, picker: picker)
            }
        }
    }
    
}

private var themePickersKey = ""