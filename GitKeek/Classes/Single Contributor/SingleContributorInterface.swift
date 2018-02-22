//
//  SingleContributorInterface.swift
//  GitKeek
//
//  Created by Sergey Kim on 22.02.2018.
//  Copyright © 2018 Sergey Kim. All rights reserved.
//

import UIKit

protocol SingleContributorInterface: Awaiting, Alarming {
    
    func setViewTitle(_ title: String)
    func setAvatarUrl(_ url: URL)
    func setUserName(_ text: NSAttributedString)
}

