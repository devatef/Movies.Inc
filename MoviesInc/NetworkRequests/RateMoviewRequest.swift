//
//  RateMoviewRequest.swift
//  MoviesInc
//
//  Created by Atef on 8/11/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import Alamofire

class RateMovieRequest: APIRequest {
    private var url:String="";
    private var parameters:[String: Any]=[:]
    private var _movieId: Int?
    private var _sessionId:String?
    var movieId: Int {
        get {
            return _movieId ?? 0
        }
        set {
            _movieId = newValue
            url = appendSuffix(endpiont: "/movie/\(newValue)/rating")
        }
    }
    var sessionId: String {
          get {
              return _sessionId ?? ""
          }
          set {
              _sessionId = newValue
          }
      }
    
    required init(parms:[String:Any]) {
        parameters = parms
    }

    func urlRequest() -> URLRequest  {
      var urlcomponents =   URLComponents(string: url)
        urlcomponents?.queryItems = []
        urlcomponents?.queryItems?.append(URLQueryItem(name: "api_key", value: APPLICATION_KEY))
        urlcomponents?.queryItems?.append(URLQueryItem(name: "guest_session_id", value: _sessionId ?? ""))

        var req = URLRequest(url:(urlcomponents?.url ?? URL(string: url)!))
        req.httpMethod = HTTPMethod.post.rawValue
        req.httpBody = parameters.percentEncoded()
        req.setValue("Content-Type", forHTTPHeaderField: "application/json;charset=utf-8")
        return req
           
    }

}

