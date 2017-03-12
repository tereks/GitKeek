//
//  AuthPresenter.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class AuthPresenter {

    weak var view: AuthInterface!
    var router: AuthRouter!
    
    func setup() {
        self.view.setAttributedMessage(AuthTextDataSource.title)
        self.view.setSignInAttributedTitle(AuthTextDataSource.SignIn)
        
        setupObservers()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.applicationOpenedViaScheme(notification:)),
                                               name: .openUrlNotification,
                                               object: nil)
    }
    
    dynamic func applicationOpenedViaScheme(notification: Notification) {
        self.view.hidePopup()
        
        guard let userInfo = notification.userInfo,
            let url = userInfo[S.url] as? URL,
            let code = url.getParameter(byName: "code") else {
                return
        }
        
        self.view.showHUD()
        
        let credentials = Credentials(clientId: R.Credentials.clientId,
                                      clientSecret: R.Credentials.clientSecret,
                                      code: code)
        GithubService.shared.getAccessToken(credentials: credentials)
        .then { accessToken -> Void in
            self.view.hideHUD()
            
            guard accessToken.characters.count > 0 else {
                return
            }
            R.Credentials.accessToken = accessToken
            GithubService.shared.configure()
            
            if let controller = self.view as? UIViewController,
                let navControler = controller.navigationController {
                self.router.pushMainController(withNavigationController: navControler)
            }
        }
        .catch { error in
            self.view.hideHUD()
            self.view.showAlert(withTitle: S.error, message: error.localizedDescription)
        }
    }
}
