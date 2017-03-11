//
//  SRepoInterface.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

protocol SRepoInterface: Awaiting, Alarming {

    func setViewTitle(_ title: String)
    func setAvatarUrl(_ url: URL)    
    func setRepoDescription(_ text: NSAttributedString)
    func setOwnerName(_ text: NSAttributedString)
    
    func setForks(_ text: String)    
    func setWatchers(_ text: String)
}
