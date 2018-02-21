//
//  ContributorsTableCell.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Kingfisher

final class ContributorsTableCell<DataType>: UITableViewCell, Configurable where DataType: UserPresentable {
 
    private var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(self.avatarView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.detailsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarView.kf.cancelDownloadTask()
        avatarView.image = nil
        titleLabel.text = ""
        detailsLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let avaratWidth = CGFloat(40)
        avatarView.frame = CGRect(x: 5, y: 5,
                                  width: avaratWidth, height: contentView.frame.height - 10)
        
        var labelWidth = contentView.frame.width - avatarView.frame.maxX - 20
        if let accessoryView = self.accessoryView {
            labelWidth = accessoryView.frame.minX - avatarView.frame.maxX - 20
        }
        
        titleLabel.frame = CGRect(x: avatarView.frame.maxX + 10, y: 0,
                                  width: labelWidth, height: contentView.frame.height / 2.0)
        detailsLabel.frame = CGRect(x: avatarView.frame.maxX + 10, y: self.contentView.frame.height / 2.0,
                                    width: labelWidth, height: contentView.frame.height / 2.0)
    }
    
    func configure(with data: DataType) {
        let url = URL(string: data.avatarUrl)
        avatarView.kf.setImage(with: url)
        titleLabel.text = data.login
        detailsLabel.text = String(describing: data.id)
    }
}
