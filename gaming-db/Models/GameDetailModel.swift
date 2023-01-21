//
//  GameDetailModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 17.01.2023.
//

import Foundation

struct GameDetailModel: Decodable {    
    let id: Int?
    let name: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double
    let playtime: Int
    let metacritic: Int?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case rating
        case playtime
        case metacritic
        case parentPlatforms = "parent_platforms"
        case genres
        case description = "description_raw"
    }
    
    init(id: Int) {
        self.id = id
        self.tba = nil
        self.name = nil
        self.released = nil
        self.backgroundImage = nil
        self.rating = 0.0
        self.playtime = 0
        self.metacritic = nil
        self.parentPlatforms = nil
        self.genres = nil
        self.description = nil
    }
}

struct ParentPlatform: Decodable {
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




