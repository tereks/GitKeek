//
//  SingleContributorController.swift
//  GitKeek
//
//  Created by Sergey Kim on 22.02.2018.
//  Copyright © 2018 Sergey Kim. All rights reserved.
//

import UIKit

final class SingleContributorController: UIViewController, SingleContributorInterface {

    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var loginLabel: UILabel!
    
    var presenter: SingleContributorPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        presenter.setup()
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
    
    func setUserName(_ text: NSAttributedString) {
        self.loginLabel.attributedText = text
    }
}
