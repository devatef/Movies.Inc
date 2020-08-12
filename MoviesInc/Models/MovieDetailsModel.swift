//
//  MovieDetailsModel.swift
//  MoviesInc
//
//  Created by Atef on 8/11/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
// MARK: - MoviesModel
struct MovieDetailsModel: Codable {
    let genres:[Genres]
    let title: String
    let vote_average: Double
    let credits:Credits

}

struct Genres: Codable {
    let id: Int
    let name: String
}

struct Credits: Codable {
    let cast:[ActorModel]
}

struct ActorModel: Codable {
    let character: String
    let name: String
    let profile_path: String?
    func getImageUrl()->String? {
        if let path = profile_path {
            return EndPoints.IMG_SUMBNAIL+path
        }
        return nil
    }
}

struct RateModel: Codable {
    let status_code :Int
    let status_message : String
}
