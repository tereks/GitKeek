//
//  AuthViewController.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Promises
import PKHUD
import SafariServices

final class AuthViewController: UIViewController, AuthInterface {

    @IBOutlet private var authButton: UIButton!
    @IBOutlet private var descLabel: UILabel!
    
    var presenter: AuthPresenter!
    
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
    
    func hideBrowser() {
        dismiss(animated: false, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func authButtonSelected(_ sender: Any) {
        presenter.onAuthButtonAction()
    }
    
    func openBrowser(url: URL) {
        let svc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
        svc.preferredControlTintColor = .white
        present(svc, animated: true, completion: nil)
    }
}
