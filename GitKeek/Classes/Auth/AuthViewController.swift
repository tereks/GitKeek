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

final class AuthViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    
    let popupvc = PTPopupWebViewController()
        .popupAppearStyle(.pop(0.2, true))
        .popupDisappearStyle(.pop(0.2, true))
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authButton.setAttributedTitle(AuthTextDataSource.SignIn, for: .normal)
        descLabel.attributedText = AuthTextDataSource.title
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.applicationOpenedViaScheme(notification:)),
                                               name: .openUrlNotification,
                                               object: nil)
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
    
    dynamic func applicationOpenedViaScheme(notification: Notification) {
        popupvc.close()
        
        guard let userInfo = notification.userInfo,
            let url = userInfo[S.url] as? URL,
            let code = url.getParameter(byName: "code") else {
            return
        }
        
        let credentials = Credentials(clientId: R.Credentials.clientId,
                                      clientSecret: R.Credentials.clientSecret,
                                      code: code)
        GithubService.shared.getAccessToken(credentials: credentials)
        .then { accessToken -> Void in
            guard accessToken.characters.count > 0 else {
                return
            }
            R.Credentials.accessToken = accessToken
            
            MainRouter.pushMainController(withNavigationController: self.navigationController)
        }
    }
}
