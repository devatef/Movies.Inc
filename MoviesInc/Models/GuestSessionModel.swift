//
//  GuestSessionModel.swift
//  MoviesInc
//
//  Created by Atef on 8/12/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import Foundation
// MARK: - GuestSessionModel
struct GuestSessionModel: Codable {
    let guest_session_id:String
    let success: Bool
    let expires_at: String
}
