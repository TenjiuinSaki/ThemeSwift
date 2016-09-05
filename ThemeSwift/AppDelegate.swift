//
//  AppDelegate.swift
//  ThemeSwift
//
//  Created by HKMac on 16/8/19.
//  Copyright © 2016年 张玉飞. All rights reserved.
//

import UIKit
import SwiftTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        MyThemes.restoreLastTheme()
        UIApplication.sharedApplication().theme_setStatusBarStyle(statusStyle, animated: true)
        
        window = UIWindow()
        window?.frame = UIScreen.mainScreen().bounds
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        let main = ViewController()
        main.title = "首页"
        let nav = UINavigationController(rootViewController: main)
        nav.tabBarItem.image = UIImage(named: "icon_tab_item")
        let tab = UITabBarController()
        tab.viewControllers = [nav]
        window?.rootViewController = tab
        
        let navBar = UINavigationBar.appearance()
        navBar.theme_tintColor = systemTintColor
        navBar.theme_barTintColor = systemBarTintColor
        let titleAttributes: [[String: AnyObject]] = systemBarTextColor.map { hexString in
            return [
                NSForegroundColorAttributeName: UIColor(rgba: hexString),
                NSFontAttributeName: UIFont.systemFontOfSize(16)
            ]
        }
        navBar.theme_titleTextAttributes = ThemeDictionaryPicker.pickerWithDicts(titleAttributes)
        
        let tabBar = UITabBar.appearance()
        tabBar.theme_tintColor = systemTintColor
        tabBar.theme_barTintColor = systemBarTintColor
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        MyThemes.saveLastTheme()
    }


}

