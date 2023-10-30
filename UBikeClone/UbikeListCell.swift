//
//  UbikeListCell.swift
//  UBikeClone
//
//  Created by 羅群瀝 on 2023/10/30.
//

import Foundation
import UIKit



class UbikeListCell: UITableViewCell{
    
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()

    
    static let identifier = "UbikeListCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Custom Label Error,init(coder:) has not been implemented")
    }
    
    func configCell(){
//        label1.text = "縣市"
        label1.textColor = .label
        label1.font = UIFont.systemFont(ofSize: 14)
//        label2.text = "區域"
        label2.textColor = .label
        label2.font = UIFont.systemFont(ofSize: 14)
//        label3.text = "站點名稱"
        label3.textColor = .label
        label3.numberOfLines = 0
        label3.font = UIFont.systemFont(ofSize: 14)
        
        label1.frame = CGRect(x: 16, y: 21, width: 44, height: 24)
        label2.frame = CGRect(x: label1.frame.maxX + 28, y: 21, width: 44, height: 24)
        label3.frame = CGRect(x: label2.frame.maxX + 32, y: 12, width: contentView.frame.width - (label2.frame.maxX + 32) - 19 + 2 , height: 48)
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
    }
    
   
}
