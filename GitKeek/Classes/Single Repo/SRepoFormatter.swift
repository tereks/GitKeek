//
//  SRepoFormatter.swift
//  GitKeek
//
//  Created by Sergey Kim on 11.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation
import SwiftRichString

struct SRepoFormatter {
    static let medium = Style("medium", {
        $0.font = FontAttribute(R.Font.RobotoMedium, size: 20)
        $0.color = UIColor.black
        $0.align = .center
        $0.paragraphSpacing = 1.5
    })
    
    static let regular14 = Style("regular", {
        $0.font = FontAttribute(R.Font.RobotoRegular, size: 14)
        $0.color = UIColor.black
        $0.align = .center
        $0.paragraphSpacing = 1.5
    })
}
