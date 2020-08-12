//
//  GuestSessionRequest.swift
//  MoviesInc
//
//  Created by Atef on 8/12/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
//https://api.themoviedb.org/3/authentication/guest_session/new?api_key=22b0de11884a4aeba3ce3a7991b42c42
import Alamofire

class GuestSessionRequest: APIRequest {
    private var url:String="";
    private var parameters:[String: Any]=[:]
    
    required init(parms:[String:Any]) {
        url = appendSuffix(endpiont: EndPoints.GUEST_SESSION)
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
