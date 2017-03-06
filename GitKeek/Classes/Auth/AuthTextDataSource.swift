//
//  AuthTextDataSource.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation
import SwiftRichString

struct AuthTextDataSource {
    
    static var SignIn: NSAttributedString {
        let medium = Style("medium", {
            $0.font = FontAttribute(R.Font.RobotoMedium, size: 20)
            $0.color = UIColor.white
            $0.align = .center
            $0.paragraphSpacing = 1.5
        })
        
        return S.signIn.set(style: medium)
    }
    
    static var title: NSAttributedString {
        let regular = Style("Regular", {
            $0.font = FontAttribute(R.Font.RobotoRegular, size: 18)
            $0.color = UIColor(white: 1, alpha: 0.5)
            $0.align = .center
            $0.paragraphSpacing = 1.5
        })
        
        return S.authTitle.set(style: regular)
    }
}
