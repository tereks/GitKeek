//
//  GitHubOauthService.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import UIKit
import Moya
import Promises
import Marshal
import Alamofire
import Promises

enum Github {
    case accessToken(credentials: Credentials)
    case repos
    case contributors
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
        case .contributors:
            return "/repos/videolan/vlc/contributors"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .accessToken(let credentials):
            return .requestParameters(parameters: ["client_id": credentials.clientId,
                                                   "client_secret": credentials.clientSecret,
                                                   "code": credentials.code],
                                      encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var authorizationType: AuthorizationType {
        return .bearer
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
    
    private init() {}
    
    var authPlugin: AccessTokenPlugin!
    var provider: MoyaProvider<Github>!
    let logger = NetworkLoggerPlugin()
    
    func configure() {
        self.authPlugin = AccessTokenPlugin(tokenClosure: { return R.Credentials.accessToken }())
        self.provider = MoyaProvider<Github>(plugins: [authPlugin, logger])
    }
    
    func authorizeAddress(withClientId clientId: String) -> String {
        let address = R.WebEndpoint + "/login/oauth/authorize?client_id=\(clientId)&scope=user%20public_repo"
        return address
    }
    
    func getAccessToken(credentials: Credentials) -> Promise<String> {
        return Promise<String> { fulfill, reject in
            self.provider.request(.accessToken(credentials: credentials)) { result in
                switch result {
                case let .success(response):
                    var token = ""
                    let value = R.BaseEndpoint + "?\(String(data: response.data, encoding: .utf8)!)"
                    if let pathURL = URL(string: value),
                        let accessToken = pathURL.getParameter(byName: R.Text.accessToken) {
                        
                        token = accessToken
                    }
                    
                    fulfill(token)
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    func getRepos() -> Promise<[Repo]> {
        return Promise<[Repo]> { fulfill, reject in
            self.provider.request(.repos) { result in
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
    
    func getContributors() -> Promise<[User]> {
        return Promise<[User]> { fulfill, reject in
            self.provider.request(.contributors) { result in
                switch result {
                case let .success(response):
                    do {
                        let users: [User] = try response.mapArray(of: User.self)
                        fulfill(users)
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
