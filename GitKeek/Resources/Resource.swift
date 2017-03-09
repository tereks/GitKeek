//
//  Resource.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation

struct R {
    
    static let BaseEndpoint = "https://github.com/login/oauth/"
    
    struct Credentials {
        static let clientId = "ef9e3e9918f5dd594388"
        static let clientSecret = "3ac5fb41590ddad98a1f94686b274494dfb4a293"
        
        static var accessToken: String {
            get {
                return UserDefaults.standard.value(forKey: S.accessToken) as? String ?? ""
            }
            set {
                UserDefaults.standard.set(newValue, forKey: S.accessToken)
            }
        }
    }
    
    struct Text {
        static let accessToken = "access_token"
    }
    
    struct Storyboard {
        static let Auth = "Auth"
        static let Main = "Main"
    }
    
    struct Font {
        static let RobotoLight = "Roboto-Light"
        static let RobotoRegular = "Roboto-Regular"
        static let RobotoMedium = "Roboto-Medium"
        static let RobotoBold = "Roboto-Bold"
    }
    
    static let Scheme = "gitkeek://"
}
