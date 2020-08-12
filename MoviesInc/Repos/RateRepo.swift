//
//  RateRepo.swift
//  MoviesInc
//
//  Created by Atef on 8/12/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import PromiseKit

class RateRepo {
    
    
 
    
     func getGuestSession() -> Promise<GuestSessionModel> {
        return Promise{ seal in
            
            NetworkHelper.shared.excuteRequest(urlRequest: GuestSessionRequest(parms: [:]),
                                               success: {data in
                                                let jsonDecoder = JSONDecoder()
                                                if let model = try? jsonDecoder.decode(GuestSessionModel.self, from: data) {
                                                    seal.fulfill(model)
                                                }else if let model = try? jsonDecoder.decode(LimitsError.self, from: data)
                                                {
                                                    seal.reject(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:model.status_message]))
                                                }
                                                else{
                                                    seal.reject(NSError(domain: "", code: -1, userInfo: nil))
                                                }
            },
                                               failure: {error in
                                                seal.reject(error)
                                                
            }
            )
            
        }
    }
    
    
    
     func rateMovie(movieId:Int,rate:Double,sessionId:String) -> Promise<RateModel> {
        
        return Promise{ seal in
            
            let rateRequest = RateMovieRequest(parms: ["value" : rate])
            rateRequest.movieId = movieId 
            rateRequest.sessionId = sessionId
            NetworkHelper.shared.excuteRequest(urlRequest: rateRequest,
                                               success: {data in
                                                let jsonDecoder = JSONDecoder()
                                                if let model = try? jsonDecoder.decode(RateModel.self, from: data) {
                                                    seal.fulfill(model)
                                                }else if let model = try? jsonDecoder.decode(LimitsError.self, from: data)
                                                {
                                                    seal.reject(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:model.status_message]))
                                                }
                                                else{
                                                    seal.reject(NSError(domain: "", code: -1, userInfo: nil))
                                                }
            },
                                               failure: {error in
                                                seal.reject(error)
                                                
            }
            )
            
        }
        
    }
}
