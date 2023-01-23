//
//  DetailsVCViewModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 18.01.2023.
//

import Foundation

protocol DetailsVCViewModelProtocol {
    var delegate: DetailsVCViewModelDelegate? { get set }
    
    func fetchGameDetail(_ id:Int)
    func getGameImageUrl() -> String?
    func getGameName() -> String?
    func getGameInfo() -> String?
    func getGameDate() -> String?
    func getGameDesc() -> String?
    func getGamePlatforms() -> [ParentPlatform]?
    func getGameRating() -> Double
    func getGamePlayingHours() -> Int?
    
    func handleFavorite() -> Bool?
    func isFavoriteGame(_ id:Int) -> Bool?
}

protocol DetailsVCViewModelDelegate: AnyObject {
    func gameLoaded()
}

final class DetailsVCViewModel: DetailsVCViewModelProtocol {
    weak var delegate: DetailsVCViewModelDelegate?
    private var game: GameDetailModel?
    
    func fetchGameDetail(_ id:Int) {
        Services.getGameDetail(gameId: id) { [weak self] game, error in
            guard let self = self else { return }
            if game?.id == nil {
                NotificationCenter.default.post(name: NSNotification.Name("getGameDetailsErrorMessage"), object: NSLocalizedString("fetched_error", comment: ""))
            }
            self.game = game
            self.delegate?.gameLoaded()
        }
    }
    
    func getGameImageUrl() -> String? {
        return game?.backgroundImage ?? ""
    }
    
    func getGameName() -> String? {
        return game?.name ?? ""
    }
    
    func getGameInfo() -> String? {
        let gameDate = (game?.tba ?? false) ? "TBA" : (game?.released?.prefix(4) ?? "TBA")
        var gameGenres = ""
        
        if let genres = game?.genres, ((game?.genres?.count ?? 0) != 0){
            for i in genres{
                gameGenres += i.name ?? ""
                gameGenres += ", "
            }
            gameGenres.removeLast(2)
        }
        return "\(gameDate) | \(gameGenres) "
    }
    
    func getGameDate() -> String? {
        if game?.tba ?? false {
            return nil
        }
        
        if let date = game?.released {
            return date
        }
        
        return nil
    }
    
    func getGameDesc() -> String? {
        return game?.description ?? ""
    }
    
    func getGamePlatforms() -> [ParentPlatform]? {
        return game?.parentPlatforms
    }
    
    func getGameRating() -> Double {
        return game?.rating ?? 0.0
    }
    
    func getGamePlayingHours() -> Int? {
        return game?.playtime
    }
    
    // TODO: control
    func handleFavorite() -> Bool?{
        if let gameId = game?.id{
            if let isFavorite = isFavoriteGame(gameId){
                if isFavorite{  return unlikeGame() }
                return likeGame()
            }
            return nil
        }
        return nil
    }
    
    func isFavoriteGame(_ id: Int) -> Bool? {
        FavoriteCoreDataManager.shared.isFavorite(id)
    }
    
    private func likeGame() -> Bool {
        if let gameId = game?.id, let imageId = URL(string: game?.backgroundImage ?? "")?.lastPathComponent {
            guard FavoriteCoreDataManager.shared.saveFavorite(gameId: gameId, imageId: imageId) != nil else { return !true }
            Constants.sharedInstance.isFavoriteChanged = true
            return true
        }
        return !true
    }
    
    private func unlikeGame() -> Bool {
        if let gameId = game?.id {
            guard FavoriteCoreDataManager.shared.deleteFavoriteWithId(id: gameId) != nil else { return !false }
            Constants.sharedInstance.isFavoriteChanged = true
            return false
        }
        return !false
    }
}
