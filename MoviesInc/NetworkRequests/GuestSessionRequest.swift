//
//  GuestSessionRequest.swift
//  MoviesInc
//
//  Created by Atef on 8/12/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
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
