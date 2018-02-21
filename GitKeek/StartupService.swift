//
//  StartupService.swift
//  GitKeek
//
//  Created by Sergey on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class StartupService {
    
    weak var window: UIWindow?
    
    init(with window: UIWindow?) {        
        self.window = window
    }
    
    func setup() {
        GithubService.shared.configure()
        
        if R.Credentials.accessToken.isEmpty {
            self.window?.rootViewController = AuthRouter.controller()
        }
        else {
            self.window?.rootViewController = MainRouter.mainTabController()
            self.window?.backgroundColor = .white
        }
    }
}
