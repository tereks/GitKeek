//
//  AuthInterface.swift
//  GitKeek
//
//  Created by Sergey on 10.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit

protocol AuthInterface: Awaiting, Alarming {
    func setAttributedMessage(_ text: NSAttributedString)
    func setSignInAttributedTitle(_ text: NSAttributedString)
    func hidePopup()
}
