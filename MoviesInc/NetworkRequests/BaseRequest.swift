//
//  BaseRequest.swift
//  MoviesInc
//
//  Created by Atef on 8/9/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequest {
    init(parms:[String:Any])
    func urlRequest() -> URLRequest
}

extension APIRequest{
    func appendSuffix(endpiont:String) -> String {
        return EndPoints.BASE_URL+EndPoints.API_VERSION+endpiont;
    }
    
    func appendCommon(parms:inout [String:Any]) {
        parms["api_key"]=APPLICATION_KEY
        parms["language"]="en-US"
        parms["page"]="1"
    }
}
