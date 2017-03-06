//
//  Api.swift
//  GitKeek
//
//  Created by Sergey Kim on 06.03.17.
//  Copyright © 2017 Sergey Kim. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum ApiError: Error {
    case Unauthorized
    case RequestFailure
    case DataFormatError
    case Unknown
}

func writeLog(string: String) {
    print("\(string)")
}

final class Api {
        
    class func getURL(forEndpoint endpoint: String) -> URL {
        let basePath = R.BaseEndpoint + endpoint
        let url = URL(string: basePath)
        return url!
    }
    
    enum Router: URLRequestConvertible {
        case accessToken(String, String, String)
        
        var method: HTTPMethod {
            switch self {
            case .accessToken:
                return .post
            default: 
                return .get
            }
            
        }
        
        var path: String {
            switch self {
            case .accessToken:
                return "/access_token"
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let url = Api.getURL(forEndpoint: path)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            
            var parameters: Parameters = [:]
            
            switch self {
            case .accessToken( let clientId, let clientSecret, let code ):
                parameters["client_id"] = clientId
                parameters["client_secret"] = clientSecret
                parameters["code"] = code
            }
            
            let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
            return encodedURLRequest 
        }
    }
    
    class func makeRequest(router: Router) -> DataRequest {
        let req = Alamofire.request(router)
            .validate(statusCode: 200..<300)
        
        writeLog(string: "\(req.description.removingPercentEncoding!)\n")
        return req
    }
    
    class func accessToken(forClientId clientId: String, clientSecret: String, code: String) -> Promise<String> {            
        return Promise { fulfill, reject in
            let request = Api.makeRequest(router: Router.accessToken(clientId, clientSecret, code))
            request.responseString { response in
                switch response.result {
                case .success:
                    guard let path = response.result.value else {
                        reject(ApiError.DataFormatError)
                        return
                    }
                    
                    if let pathURL = URL(string: R.BaseEndpoint + "?\(path)"),
                        let accessToken = pathURL.getParameter(byName: "access_token") {
                        
                        fulfill(accessToken)
                        return
                    }
                    fulfill("")
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
