//
//  searchResultCell.swift
//  UBikeClone
//
//  Created by 羅群瀝 on 2023/10/30.
//

import Foundation
import UIKit


class searchResultCell: UITableViewCell{
    
    static let identifier = "searchResultCell"
    
    var label = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.frame = CGRect(x: 16, y: 8, width: contentView.frame.width - 32, height: 20)
        contentView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Custom Label Error,init(coder:) has not been implemented")
    }
}
