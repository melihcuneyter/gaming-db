//
//  FavoritesVCViewModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 17.01.2023.
//

import Foundation

protocol FavoritesVCViewModelProtocol {
    var delegate: FavoritesVCViewModelDelegate? { get set }
    
    func fetchFavoriteGames()
    func getGameCount() -> Int
    func getGame(at index: Int) -> GameDetailModel?
    func getGameID(at index: Int) -> Int?
    func removeFavoriteGame(at index:Int)
    func getGameName(at index: Int) -> String?
}

protocol FavoritesVCViewModelDelegate: AnyObject {
    func favoritesFetched()
}

final class FavoritesVCViewModel: FavoritesVCViewModelProtocol {
    weak var delegate: FavoritesVCViewModelDelegate?
    private var favorites = [Favorite]()
    private var games: [GameDetailModel]?
    
    func fetchFavoriteGames() {
        Constants.sharedInstance.isFavoriteChanged = false
        
        games = [GameDetailModel]()
        favorites = FavoriteCoreDataManager.shared.getFavorites()
        favorites = favorites.reversed()
        
        var onQueue = favorites.count
        
        if favorites.count <= 0 {
            delegate?.favoritesFetched()
            return
        }
        
        for i in favorites.enumerated() {
            games?.append(GameDetailModel(id: Int(i.element.gameID)))
            Services.getGameDetail(gameId: Int(i.element.gameID)) { [weak self] game, error in
                guard let self = self else { return }
                if let game {
                    if game.id == nil {
                        self.favorites.removeAll()
                        NotificationCenter.default.post(name: NSNotification.Name("favoriteGamesErrorMessage"), object: NSLocalizedString("fetched_error", comment: ""))
                        return
                    }
                    
                    self.games?[i.offset] = game
                    onQueue -= 1
                    
                    if(onQueue <= 0) {
                        self.delegate?.favoritesFetched()
                    }
                }
            }
        }
    }
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameDetailModel? {
        games?[index]
    }
    
    func getGameID(at index: Int) -> Int? {
        games?[index].id
    }
    
    func getGameName(at index: Int) -> String? {
        games?[index].name
    }
    
    func getGameImageId(at index: Int) -> String? {
        URL(string: games?[index].backgroundImage ?? "")?.lastPathComponent
    }
    
    func removeFavoriteGame(at index:Int) {
        FavoriteCoreDataManager.shared.deleteFavorite(game: favorites[index])
        favorites.remove(at: index)
        games?.remove(at: index)
        self.delegate?.favoritesFetched()
    }
}
