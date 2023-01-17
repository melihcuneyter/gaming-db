//
//  FeedVCViewModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 17.01.2023.
//

import Foundation

protocol FeedVCViewModelProtocol {
    var delegate: FeedVCViewModelDelegate? { get set }
    
    func getAllGames()
    func getGameCount() -> Int
    func getGame(at index: Int) -> GameModel?
}

protocol FeedVCViewModelDelegate: AnyObject {
    func fetchedGames()
}

final class FeedVCViewModel: FeedVCViewModelProtocol {
    weak var delegate: FeedVCViewModelDelegate?
    
    private var games: [GameModel]?
    private var tempGames: [GameModel]?
    
    func getAllGames() {
        Services.getAllGames { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                NotificationCenter.default.post(name: NSNotification.Name("getAllGamesErrorMessage"), object: error.localizedDescription)
                self.delegate?.fetchedGames()
                return
            }
            self.games = games
            self.tempGames = games
            self.delegate?.fetchedGames()
        }
    }
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameModel? {
        games?[index]
    }
}
