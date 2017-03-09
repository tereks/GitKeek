//
//  GitHubOauthService.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Moya
import PromiseKit

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

enum Github {
    case accessToken(credentials: Credentials)
}

extension Github: TargetType {
    var baseURL: URL { 
        return URL(string: R.BaseEndpoint)! 
    }
    
    var path: String {
        switch self {
        case .accessToken:
            return "/access_token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accessToken:
            return .get
        default:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .accessToken(let credentials):
            return ["client_id": credentials.clientId, 
                    "client_secret": credentials.clientSecret,
                    "code": credentials.code]            
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        return .request
    }
    
    var validate: Bool {
        return true
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}

func writeLog(string: String) {
    print("\(string)")
}

final class GithubService {
    
    static let shared = GithubService()
    
    private init() {
    }
    
    var provider = MoyaProvider<Github>()
    
    func authorizeURL(withClientId clientId: String) -> URL? {        
        let oauthPath = R.BaseEndpoint + "authorize?client_id=\(clientId)&scope=user%20public_repo"
        
        guard let oauthUrl = URL(string: oauthPath) else {
            return nil
        }
        return oauthUrl
    }
    
    func getAccessToken(credentials: Credentials) -> Promise<String> {
        
        return Promise { fulfill, reject in
            provider.request(.accessToken(credentials: credentials)) { result in
                switch result {
                case let .success(response):
                    
                    let value = R.BaseEndpoint + "?\(String(data: response.data, encoding: .utf8)!)"
                    if let pathURL = URL(string: value),
                        let accessToken = pathURL.getParameter(byName: R.Text.accessToken) {
                        
                        fulfill(accessToken)
                        return
                    }
                    
                    fulfill("")
                case let .failure(error):
                    reject(error)
                }                
            }            
        }
    }
}
