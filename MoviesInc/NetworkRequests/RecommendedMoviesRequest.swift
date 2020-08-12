//
//  RecommendedMoviesRequest.swift
//  MoviesInc
//
//  Created by Atef on 8/12/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation

class RecommendedMoviesRequest: HomeMovieRequest {
    private var _movieId:Int = 0
    var movieId: Int {
         get {
             return _movieId
         }
         set {
             _movieId = newValue
             url = appendSuffix(endpiont: "/movie/\(newValue)/recommendations")
         }
     }
    
  

}

