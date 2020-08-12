//
//  EndPoints.swift
//  MoviesInc
//
//  Created by Atef on 8/9/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
class EndPoints {
    
    static let BASE_URL = "https://api.themoviedb.org/"
    static let API_VERSION = "3"
    static let NOW_PLAYING = "/movie/now_playing"
    static let IMG_PATH = "https://image.tmdb.org/t/p/"
    static let IMG_SUMBNAIL = IMG_PATH+"w185"
    static let IMG_POSTER = IMG_PATH+"w500"
    static let GUEST_SESSION = "/authentication/guest_session/new"
    
   // https://api.themoviedb.org/3/movie/now_playing?api_key=<<api_key>>&language=en-US&page=1
    //https://api.themoviedb.org/3/movie/550?api_key=22b0de11884a4aeba3ce3a7991b42c42&append_to_response=credits
    //https://api.themoviedb.org/3/authentication/guest_session/new?api_key=22b0de11884a4aeba3ce3a7991b42c42

}
