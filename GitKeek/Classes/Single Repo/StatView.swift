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
        self.forksTitle.sizeToFit()
        self.addSubview(self.forksTitle)
        self.addSubview(self.watchersTitle)
        self.addSubview(self.forksValue)
        self.addSubview(self.watchersValue)
    }
    
    override func updateConstraints() {
        let titleHeight = self.forksTitle.frame.height
        
        constrain(self, self.forksTitle, self.watchersTitle, self.forksValue, self.watchersValue) {
            superview, forksTitle, watchersTitle, forksValue, watchersValue in
                        
            forksTitle.top == superview.top
            forksTitle.left == superview.left
            forksTitle.right == watchersTitle.left
            forksTitle.height == titleHeight
            
            watchersTitle.top == superview.top
            watchersTitle.right == superview.right
            watchersTitle.left == forksTitle.right
            watchersTitle.width == forksTitle.width
            watchersTitle.height == titleHeight
            
            forksValue.top == forksTitle.bottom
            forksValue.bottom == superview.bottom
            forksValue.left == superview.left
            forksValue.right == watchersValue.left
            
            watchersValue.top == forksTitle.bottom
            watchersValue.bottom == superview.bottom
            watchersValue.right == superview.right
            watchersValue.width == forksValue.width
        }
        
        super.updateConstraints()
    }
}
