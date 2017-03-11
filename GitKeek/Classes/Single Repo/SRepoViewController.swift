//
//  SRepoViewController.swift
//  GitKeek
//
//  Created by Sergey on 09.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher
    
final class SRepoViewController: UIViewController, SRepoInterface {

    var presenter: SRepoPresenter!

    var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var ownerLabel = UILabel()
    var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var statsContainer = StatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.avatarView)
        self.view.addSubview(self.ownerLabel)
        self.view.addSubview(self.separator)
        self.view.addSubview(self.descLabel)
        
        self.view.addSubview(self.statsContainer)
        
        presenter.setup()        
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        constrain(self.view, self.avatarView, self.ownerLabel, self.separator, self.descLabel) {
            superview, avatarView, ownerLabel, separator, descLabel in
            
            avatarView.width == superview.width / 3
            avatarView.height == avatarView.width
            avatarView.top == superview.topMargin + 85
            avatarView.centerX == superview.centerX
            
            ownerLabel.top == avatarView.bottom + 10
            ownerLabel.left == superview.left + 15
            ownerLabel.right == superview.right - 15
            
            separator.top == ownerLabel.bottom + 15
            separator.left == superview.left + 15
            separator.right == superview.right - 15
            separator.height == 1.0 / UIScreen.main.scale
            
            descLabel.top == separator.bottom + 15
            descLabel.left == superview.left + 15
            descLabel.right == superview.right - 15
            descLabel.height <= 100
        }
        
        constrain(self.view, self.statsContainer, self.descLabel) {
            superview, statsContainer, descLabel in
            
            statsContainer.top == descLabel.bottom + 25
            statsContainer.centerX == superview.centerX
            statsContainer.width == 200
            statsContainer.height == 60
        }
        
        super.updateViewConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        presenter.update()
    }
    
    func setViewTitle(_ title: String) {
        self.title = title
    }
    
    func setAvatarUrl(_ url: URL) {
        self.avatarView.kf.setImage(with: url)
    }
    
    func setOwnerName(_ text: NSAttributedString) {
        self.ownerLabel.attributedText = text
    }
    
    func setRepoDescription(_ text: NSAttributedString) {
        self.descLabel.attributedText = text
    }
    
    func setForks(_ text: String) {
        self.statsContainer.forks = text
    }
    
    func setWatchers(_ text: String) {
        self.statsContainer.watchers = text
    }
}
