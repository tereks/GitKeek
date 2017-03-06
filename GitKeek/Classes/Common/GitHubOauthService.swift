//
//  GitHubOauthService.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

struct GitHubOauthService {
    
    static func signIn(withClientId clientId: String) {
        
        let oauthPath = R.BaseEndpoint + "authorize?client_id=\(clientId)&scope=user%20public_repo"
        
        guard let oauthUrl = URL(string: oauthPath) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(oauthUrl) {
            UIApplication.shared.openURL(oauthUrl)
        }
    }
    
    static func getAccessToken(withCode code: String) {
        Api.accessToken(forClientId: R.Credentials.clientId, 
                        clientSecret: R.Credentials.clientSecret, 
                        code: code)
        .then { accessToken -> Void in
            R.Credentials.accessToken = accessToken
            NotificationCenter.default.post(
                name: .accessTokenNotification,
                object: self,
                userInfo: nil
            )
        }
        .catch { error in
            print("Error - \(error)")
        }
    }
}
