//
//  StatView.swift
//  GitKeek
//
//  Created by Sergey Kim on 11.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Cartography
import SwiftRichString

let regular14 = Style("regular", {
    $0.font = FontAttribute(R.Font.RobotoRegular, size: 14)
    $0.color = UIColor.black
    $0.align = .center
    $0.paragraphSpacing = 1.5
})

let medium = Style("medium", {
    $0.font = FontAttribute(R.Font.RobotoMedium, size: 18)
    $0.color = UIColor.blue
    $0.align = .center
    $0.paragraphSpacing = 1.5
})

final class StatView: UIView {

    private var forksTitle: UILabel = {
        let label = UILabel()
        label.attributedText = R.L10.forks.set(style: regular14)
        return label
    }()
    
    private var watchersTitle: UILabel = {
        let label = UILabel()
        label.attributedText = R.L10.watchers.set(style: regular14)
        return label
    }()
    
    private var watchersValue = UILabel()
    private var forksValue = UILabel()    
    
    var forks: String = "" {
        didSet {
            self.forksValue.attributedText = forks.set(style: medium)
        }
    }
    var watchers: String = "" {
        didSet {
            self.watchersValue.attributedText = watchers.set(style: medium)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(self.forksTitle)
        self.addSubview(self.watchersTitle)
        self.addSubview(self.forksValue)
        self.addSubview(self.watchersValue)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.forksTitle.sizeToFit()
        
        let titleHeight = self.forksTitle.frame.height
        let titleWidth = self.frame.width / 2.0
        
        self.forksTitle.frame = CGRect(x: 0, y: 0, width: titleWidth, height: titleHeight)
        self.watchersTitle.frame = CGRect(x: self.forksTitle.frame.maxX, y: 0, width: titleWidth, height: titleHeight)
        
        let valueHeight = self.frame.height - titleHeight
        
        self.forksValue.frame = CGRect(x: 0, y: self.forksTitle.frame.maxY, width: titleWidth, height: valueHeight)
        self.watchersValue.frame = CGRect(x: self.forksTitle.frame.maxX, y: self.forksTitle.frame.maxY, width: titleWidth, height: valueHeight)
    }
}
