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
    func getMoreGames(nextPageURL: String)
    func getMoreGame() -> String
    func getOrderedGames(orderBy: String)
}

protocol FeedVCViewModelDelegate: AnyObject {
    func fetchedGames()
}

final class FeedVCViewModel: FeedVCViewModelProtocol {
    weak var delegate: FeedVCViewModelDelegate?
    
    private var games: [GameModel]?
    private var nextPageURL: String?
    
    func getAllGames() {
        Services.getAllGames { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                NotificationCenter.default.post(name: NSNotification.Name("getAllGamesErrorMessage"), object: error.localizedDescription)
                self.delegate?.fetchedGames()
                return
            }
            
            self.nextPageURL = games?.next
            self.games = games?.results
            self.delegate?.fetchedGames()
        }
    }
    // TODO: eğer nextpage yok ise istek atma.
    func getMoreGames(nextPageURL: String) {
        Services.getMoreGames(nextPageURL: nextPageURL) { [weak self] moreGame, error in
            guard let self = self else { return }
            if let error = error {
                NotificationCenter.default.post(name: NSNotification.Name("getMoreGamesErrorMessage"), object: error.localizedDescription)
                self.delegate?.fetchedGames()
                return
            }
            
            self.nextPageURL = moreGame!.next
            self.games?.append(contentsOf: moreGame!.results)
            self.delegate?.fetchedGames()
        }
    }
    
    func getOrderedGames(orderBy: String) {
        Services.getOrderedGames(orderBy: orderBy) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                NotificationCenter.default.post(name: NSNotification.Name("getOrderedGamesErrorMessage"), object: error.localizedDescription)
                self.delegate?.fetchedGames()
                return
            }
            
            self.nextPageURL = games?.next
            self.games = games?.results
            self.delegate?.fetchedGames()
        }
    }
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameModel? {
        games?[index]
    }
    
    func getMoreGame() -> String {
        nextPageURL!
    }
}
