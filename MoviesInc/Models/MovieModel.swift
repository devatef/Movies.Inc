//
//  MovieModel.swift
//  MoviesInc
//
//  Created by Atef on 8/10/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation

// MARK: - MoviesModel
struct MoviesModel: Codable {
    let results: [Movie]
    let page: Int
    let total_results: Int
}

// MARK: - Movie
struct Movie: Codable {
    let title: String
    let release_date: String
    let poster_path: String
    let vote_average: Double
    let id: Int
    let overview: String
    func getImageUrl()->String{
        return EndPoints.IMG_SUMBNAIL+poster_path
    }
    func getLargeImageUrl()->String{
           return EndPoints.IMG_POSTER+poster_path
       }
}

// MARK: - Error
struct LimitsError: Codable {
    let status_message: String
    let success: Bool
}
