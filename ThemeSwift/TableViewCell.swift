//
//  TableViewCell.swift
//  ThemeSwift
//
//  Created by HKMac on 16/8/19.
//  Copyright © 2016年 张玉飞. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    let iconView = UIImageView()
    let titleLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        iconView.snp_makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(20)
            make.width.height.equalTo(25)
        }
        iconView.contentMode = .Center
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(70)
            make.height.right.centerY.equalTo(contentView)
        }
        theme_backgroundColor = systemBackgroundColor
        titleLabel.theme_textColor = systemTextColor
        titleLabel.backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
