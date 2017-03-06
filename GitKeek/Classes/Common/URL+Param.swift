//
//  URL+param.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation

extension URL {
    
    func getParameter(byName name: String) -> String? {
        if let urlComponents = URLComponents(string: self.absoluteString), 
            let queryItems = (urlComponents.queryItems) {
            
            return queryItems.filter{ $0.name == name }.first?.value ?? ""
        }
        return nil
    }
}
