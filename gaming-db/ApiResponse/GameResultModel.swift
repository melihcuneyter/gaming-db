//
//  GameResultModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 17.01.2023.
//

import Foundation

struct GamesResultModel: Decodable {
    let next: String
    let previous: String?
    let results: [GameModel]
}
