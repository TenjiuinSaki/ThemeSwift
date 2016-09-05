//
//  ViewController.swift
//  ThemeSwift
//
//  Created by HKMac on 16/8/19.
//  Copyright © 2016年 张玉飞. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tableView = UITableView(frame: view.bounds, style: .Grouped)
        view.addSubview(tableView)
        tableView.theme_backgroundColor = systemBackgroundColor
        tableView.theme_separatorColor = systemSeparatorColor
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        tableView.tableHeaderView = headerView
        headerView.theme_backgroundColor = systemBackgroundColor
        
        let label = UILabel()
        label.text = "iOS换肤示例"
        label.font = UIFont.systemFontOfSize(35)
        label.theme_textColor = systemTextColor
        headerView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.center.equalTo(headerView)
        }
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: 200)
        tableView.tableFooterView = footerView
        
        let button = UIButton()
        button.theme_setTitleColor(systemTintColor, forState: .Normal)
        button.theme_backgroundColor = systemBarTintColor
        button.setTitle("一键换肤", forState: .Normal)
        footerView.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.center.equalTo(footerView)
            make.width.height.equalTo(100)
        }
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changeTheme), forControlEvents: .TouchUpInside)
    }
    func changeTheme() {
        MyThemes.switchToNext()
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        if indexPath.row == 0 {
            cell.iconView.theme_image = iconImage
            cell.titleLabel.text = "皮肤中心"
        }
        if indexPath.row == 1 {
            cell.iconView.theme_image = nightImage
            cell.titleLabel.text = "夜间"
        }
        return cell
    }
    func changeNight(sender: UISwitch) {
        MyThemes.switchNight(sender.on)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.separatorInset = UIEdgeInsetsZero
//        tableView.layoutMargins = UIEdgeInsetsZero
//        cell.layoutMargins = UIEdgeInsetsZero
//    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(ThemeSelectController(), animated: true)
        }
        if indexPath.row == 1 {
            MyThemes.switchNight(!MyThemes.isNight())
        }
    }
}
