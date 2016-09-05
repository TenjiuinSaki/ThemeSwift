//
//  ThemeSelectController.swift
//  ThemeSwift
//
//  Created by HKMac on 16/8/19.
//  Copyright © 2016年 张玉飞. All rights reserved.
//

import UIKit

class ThemeSelectController: UITableViewController {
    let themeArray = ["落英缤纷","一米阳光","蓝色经典"]
    let colorArray = ["#EB4F38", "#F4C600", "#56ABE4"]
    let tintColorArray = ["#FFF", "#000", "#FFF"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "皮肤中心"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.theme_backgroundColor = systemBackgroundColor
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = themeArray[indexPath.row]
        cell.contentView.backgroundColor = UIColor(rgba: colorArray[indexPath.row])
        cell.textLabel?.textColor = UIColor(rgba: tintColorArray[indexPath.row])
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.contentView.snp_makeConstraints { (make) in
            make.center.equalTo(cell)
            make.width.height.equalTo(cell).offset(-30)
        }
        cell.textLabel?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(cell.contentView)
        })
        cell.textLabel?.textAlignment = .Center
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.selectionStyle = .None
        cell.theme_backgroundColor = systemBackgroundColor
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0: MyThemes.switchTo(.Red)
        case 1: MyThemes.switchTo(.Yello)
        case 2: MyThemes.switchTo(.Blue)
        default:
            ()
        }
    }
}
