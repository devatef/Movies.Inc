//
//  MovieRepo.swift
//  MoviesInc
//
//  Created by Atef on 8/10/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
import PromiseKit

class MovieRepo {
    
    func loadMovies() -> Promise<MoviesModel> {
        
        return Promise{ seal in
            NetworkHelper.shared.excuteRequest(urlRequest: HomeMovieRequest(parms: [: ]),
                                         success: {data in
                                            let jsonDecoder = JSONDecoder()
                                            if let model = try? jsonDecoder.decode(MoviesModel.self, from: data) {
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
    
    func loadMovieDeatils(movieId:Int) -> Promise<MovieDetailsModel> {
         
         return Promise{ seal in
            let request = MovieDetailsRequest(parms: ["append_to_response":"credits"])
            request.movieId = movieId
             NetworkHelper.shared.excuteRequest(urlRequest: request,
                                          success: {data in
                                             let jsonDecoder = JSONDecoder()
                                             if let model = try? jsonDecoder.decode(MovieDetailsModel.self, from: data) {
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
