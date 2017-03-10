//
//  StartupService.swift
//  GitKeek
//
//  Created by Sergey on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

struct StartupService {
    
    weak var window: UIWindow?
    
    init(withWindow window: UIWindow?) {        
        self.window = window        
        setup()
    }
    
    func setup() {
        GithubService.shared.configure()
        
        if R.Credentials.accessToken.isEmpty {
            self.window?.rootViewController = AuthRouter.controller()
            return 
        }
        
        self.window?.rootViewController = MainRouter.mainTabController()
        self.window?.backgroundColor = .white
    }
}
