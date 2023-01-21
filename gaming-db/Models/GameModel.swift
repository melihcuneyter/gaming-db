//
//  GameModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 17.01.2023.
//

import Foundation

struct GameModel: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double
    let metacritic: Int?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case rating
        case metacritic
        case parentPlatforms = "parent_platforms"
        case genres
    }
}
