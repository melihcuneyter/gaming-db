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
    let metacritic: Int?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case metacritic
        case parentPlatforms = "parent_platforms"
        case genres
    }
}

struct ParentPlatform: Decodable{
    let platform: Platform?
}

struct Platform: Decodable {
    let id: Int?
    let name: String?
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
}
