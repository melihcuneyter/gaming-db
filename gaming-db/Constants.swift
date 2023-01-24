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
    var baseImageURL: String =  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS9oDX09M6mwiMyr1L336xN4TFDuRdDdtAqo4G_rFeKbAjwUA0HRWjLfiSSRfLGTKNp5M&usqp=CAU"
}

struct Keys {
    static let apiURL = "https://api.rawg.io/api/games"
    static let apiKEY = "6ef9bfc002e7458a80db583847b49012"
}
