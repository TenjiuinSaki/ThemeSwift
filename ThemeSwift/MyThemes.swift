//
//  MyThemes.swift
//  Demo
//
//  Created by Gesen on 16/3/14.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import SwiftTheme

private let lastThemeIndexKey = "lastedThemeIndex"
private let defaults = NSUserDefaults.standardUserDefaults()

enum MyThemes: Int {
    
    case Red   = 0
    case Yello = 1
    case Blue  = 2
    case Night = 3
    
    // MARK: -
    
    static var current: MyThemes { return MyThemes(rawValue: ThemeManager.currentThemeIndex)! }
    static var before = MyThemes.Red
    
    // MARK: - Switch Theme
    
    static func switchTo(theme: MyThemes) {
        before = current
        ThemeManager.setTheme(theme.rawValue)
    }
    
    static func switchToNext() {
        var next = ThemeManager.currentThemeIndex + 1
        if next > 2 { next = 0 } // cycle and without Night
        switchTo(MyThemes(rawValue: next)!)
    }
    
    // MARK: - Switch Night
    
    static func switchNight(isToNight: Bool) {
        switchTo(isToNight ? .Night : before)
    }
    
    static func isNight() -> Bool {
        return current == .Night
    }
    
    // MARK: - Save & Restore
    
    static func restoreLastTheme() {
        switchTo(MyThemes(rawValue: defaults.integerForKey(lastThemeIndexKey))!)
    }
    
    static func saveLastTheme() {
        defaults.setInteger(ThemeManager.currentThemeIndex, forKey: lastThemeIndexKey)
    }
    
}