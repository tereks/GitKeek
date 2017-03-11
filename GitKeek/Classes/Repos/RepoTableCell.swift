//
//  RepoTableCell.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class RepoTableCell<DataType>: UITableViewCell, Configurable where DataType: RepoPresentable {
 
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.detailsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rightMargin = self.contentView.frame.width - CGFloat(15)
        if let accessoryView = self.accessoryView {
            rightMargin = accessoryView.frame.minX - CGFloat(10)
        }
        self.titleLabel.frame = CGRect(x: 15, y: 0, width: rightMargin, height: self.contentView.frame.height / 2.0)
        self.detailsLabel.frame = CGRect(x: 15, y: self.contentView.frame.height / 2.0, 
                                         width: rightMargin, height: self.contentView.frame.height / 2.0)
    }
    
    func config(withData data: DataType) {
        self.titleLabel.text = data.name
        self.detailsLabel.text = data.language
    }
}
