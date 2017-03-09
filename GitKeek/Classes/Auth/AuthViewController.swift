//
//  AuthViewController.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class AuthViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authButton.setAttributedTitle(AuthTextDataSource.SignIn, for: .normal)
        descLabel.attributedText = AuthTextDataSource.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func authButtonSelected(_ sender: Any) {
        if let oauthUrl = GithubService.shared.authorizeURL(withClientId: R.Credentials.clientId) {        
            if UIApplication.shared.canOpenURL(oauthUrl) {
                UIApplication.shared.openURL(oauthUrl)
            }
        }
    }
}
