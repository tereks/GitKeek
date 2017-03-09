//
//  AuthRouter.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

final class AuthRouter: NSObject {

    class func controller() -> UINavigationController? {
        let storyboard = UIStoryboard(name: R.Storyboard.Auth, bundle: nil)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            return nil
        }
        
        guard let _ = navController.topViewController as? AuthViewController else {
            return nil
        }
        
        return navController
    }
}
