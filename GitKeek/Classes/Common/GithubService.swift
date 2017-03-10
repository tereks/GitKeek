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
import Marshal


enum Github {
    case accessToken(credentials: Credentials)
    case repos
}

enum ApiError: Swift.Error {
    case ResponseValidationFailed
}

extension Github: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        switch self {
        case .accessToken:
            return URL(string: R.WebEndpoint)!
        default:
            return URL(string: R.BaseEndpoint)!
        }
    }
    
    var path: String {
        switch self {
        case .accessToken:
            return "/login/oauth/access_token"
        case .repos:
            return "/user/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accessToken, .repos:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .accessToken(let credentials):
            return ["client_id": credentials.clientId, 
                    "client_secret": credentials.clientSecret,
                    "code": credentials.code]
        case .repos:
            return nil
        }
    }
    
    var shouldAuthorize: Bool {
        switch self {
        case .accessToken:
            return false
        default:
            return true
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
    
    var authPlugin: AccessTokenPlugin!
    var provider: MoyaProvider<Github>!
    let logger = NetworkLoggerPlugin()
    
    func configure() {
        self.authPlugin = AccessTokenPlugin(token: R.Credentials.accessToken)
        self.provider = MoyaProvider<Github>(plugins: [authPlugin, logger])
    }
    
    func authorizeAddress(withClientId clientId: String) -> String {
        let address = R.WebEndpoint + "/login/oauth/authorize?client_id=\(clientId)&scope=user%20public_repo"
        return address
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
    
    func getRepos() -> Promise<[Repo]> {
        return Promise { fulfill, reject in
            provider.request(.repos) { result in
                switch result {
                case let .success(response):
                    do {
                        let repos: [Repo] = try response.mapArray(of: Repo.self)
                        fulfill(repos)
                    } catch {
                        reject(ApiError.ResponseValidationFailed)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
}
