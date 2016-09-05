//
//  ThemeManager.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

public let ThemeUpdateNotification = "ThemeUpdateNotification"

public enum ThemePath {
    
    case MainBundle
    case Sandbox(NSURL)
    
    public var URL: NSURL? {
        switch self {
        case .MainBundle        : return nil
        case .Sandbox(let path) : return path
        }
    }
    
    public func plistPathByName(name: String) -> String? {
        switch self {
        case .MainBundle:        return NSBundle.mainBundle().pathForResource(name, ofType: "plist")
        case .Sandbox(let path): return NSURL(string: name + ".plist", relativeToURL: path)?.path
        }
    }
}

public class ThemeManager: NSObject {
    
    public static var animationDuration = 0.3
    
    public private(set) static var currentTheme      : NSDictionary?
    public private(set) static var currentThemePath  : ThemePath?
    public private(set) static var currentThemeIndex : Int = 0
    
    public class func setTheme(index: Int) {
        currentThemeIndex = index
        NSNotificationCenter.defaultCenter().postNotificationName(ThemeUpdateNotification, object: nil)
    }
    
    public class func setTheme(plistName: String, path: ThemePath) {
        guard let plistPath = path.plistPathByName(plistName)         else {
            print("SwiftTheme WARNING: Not find plist '\(plistName)' with: \(path)")
            return
        }
        guard let plistDict = NSDictionary(contentsOfFile: plistPath) else {
            print("SwiftTheme WARNING: Not read plist '\(plistName)' with: \(plistPath)")
            return
        }
        self.setTheme(plistDict, path: path)
    }
    
    public class func setTheme(dict: NSDictionary, path: ThemePath) {
        currentTheme = dict
        currentThemePath = path
        NSNotificationCenter.defaultCenter().postNotificationName(ThemeUpdateNotification, object: nil)
    }
    
}

extension ThemeManager {
    
    public class func colorForArray(array: [String]) -> UIColor? {
        guard let rgba = elementForArray(array) else { return nil }
        guard let color = try? UIColor(rgba_throws: rgba as String) else {
            print("SwiftTheme WARNING: Not convert rgba \(rgba) in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return color
    }
    
    public class func imageForArray(array: [String]) -> UIImage? {
        guard let imageName = elementForArray(array) else { return nil }
        guard let image = UIImage(named: imageName as String) else {
            print("SwiftTheme WARNING: Not found image name '\(imageName)' in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return image
    }
    
    public class func elementForArray<T: AnyObject>(array: [T]) -> T? {
        let index = ThemeManager.currentThemeIndex
        guard  array.indices ~= index else {
            print("SwiftTheme WARNING: Not found element in array: \(array)[\(currentThemeIndex)]")
            return nil
        }
        return array[index]
    }
    
}

extension ThemeManager {
    
    public class func stringForKeyPath(keyPath: String) -> String? {
        guard let string = currentTheme?.valueForKeyPath(keyPath) as? String else {
            print("SwiftTheme WARNING: Not found string key path: \(keyPath)")
            return nil
        }
        return string
    }
    
    public class func numberForKeyPath(keyPath: String) -> NSNumber? {
        guard let number = currentTheme?.valueForKeyPath(keyPath) as? NSNumber else {
            print("SwiftTheme WARNING: Not found number key path: \(keyPath)")
            return nil
        }
        return number
    }
    
    public class func dictionaryForKeyPath(keyPath: String) -> NSDictionary? {
        guard let dict = currentTheme?.valueForKeyPath(keyPath) as? NSDictionary else {
            print("SwiftTheme WARNING: Not found dictionary key path: \(keyPath)")
            return nil
        }
        return dict
    }
    
    public class func colorForKeyPath(keyPath: String) -> UIColor? {
        guard let rgba = stringForKeyPath(keyPath) else { return nil }
        guard let color = try? UIColor(rgba_throws: rgba) else {
            print("SwiftTheme WARNING: Not convert rgba \(rgba) at key path: \(keyPath)")
            return nil
        }
        return color
    }
    
    public class func imageForKeyPath(keyPath: String) -> UIImage? {
        guard let imageName = stringForKeyPath(keyPath) else { return nil }
        if let filePath = currentThemePath?.URL?.URLByAppendingPathComponent(imageName).path {
            guard let image = UIImage(contentsOfFile: filePath) else {
                print("SwiftTheme WARNING: Not found image at file path: \(filePath)")
                return nil
            }
            return image
        } else {
            guard let image = UIImage(named: imageName) else {
                print("SwiftTheme WARNING: Not found image name at main bundle: \(imageName)")
                return nil
            }
            return image
        }
    }
    
}
