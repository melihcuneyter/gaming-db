//
//  Constants.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import Foundation

final class Constants {
    static let sharedInstance = Constants()
    private init(){}
        
    var isFavoriteChanged = false
    var isNotesChanged = false
}

struct Keys {
    static let apiURL = "https://api.rawg.io/api/games"
    static let apiKEY = "6ef9bfc002e7458a80db583847b49012"
}
