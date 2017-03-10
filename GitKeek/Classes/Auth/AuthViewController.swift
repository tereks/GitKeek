//
//  AuthViewController.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import PTPopupWebView
import PromiseKit
import PKHUD

final class AuthViewController: UIViewController, AuthInterface {

    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    
    var presenter: AuthPresenter!
    
    let popupvc = PTPopupWebViewController()
        .popupAppearStyle(.pop(0.2, true))
        .popupDisappearStyle(.pop(0.2, true))
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setup()
    }
    
    func setAttributedMessage(_ text: NSAttributedString) {
        descLabel.attributedText = text
    }
    
    func setSignInAttributedTitle(_ text: NSAttributedString) {
        authButton.setAttributedTitle(text, for: .normal)
    }
    
    func hidePopup() {
        popupvc.close()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func authButtonSelected(_ sender: Any) {
        let oauthAddress = GithubService.shared.authorizeAddress(withClientId: R.Credentials.clientId)
        let _ = popupvc.popupView.URL(string: oauthAddress)
        let _ = popupvc.popupView.addExternalLinkPattern(.URLScheme)
        popupvc.show()
    }
}
