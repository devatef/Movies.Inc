//
//  MovieDetailsRequest.swift
//  MoviesInc
//
//  Created by Atef on 8/11/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import Alamofire

class MovieDetailsRequest: APIRequest {
    private var url:String="";
    private var parameters:[String: Any]=[:]
    private var _movieId:Int?
    
    var movieId: Int {
         get {
             return _movieId ?? 0
         }
         set {
             _movieId = newValue
             url = appendSuffix(endpiont: "/movie/\(newValue)")
         }
     }
    
    required init(parms:[String:Any]) {
        parameters = parms
        appendCommon(parms: &parameters)
    }

    func urlRequest() -> URLRequest  {
      var urlcomponents =   URLComponents(string: url)
        urlcomponents?.queryItems = []
        for (key,value) in parameters {
            urlcomponents?.queryItems?.append(URLQueryItem(name: key, value: (value as! String)))
        }
        var req = URLRequest(url:(urlcomponents?.url ?? URL(string: url)!))
        req.httpMethod = HTTPMethod.get.rawValue
        req.setValue("Content-Type", forHTTPHeaderField: "application/json;charset=utf-8")
        return req
           
    }

}
