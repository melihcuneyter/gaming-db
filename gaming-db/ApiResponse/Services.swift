//
//  Services.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 17.01.2023.
//

import UIKit
import Alamofire

final class Services {
    static func getAllGames(completion: @escaping (GamesResultModel?, Error?) -> Void) {
        let urlString = Keys.apiURL + "?key=" + Keys.apiKEY
        handleResponse(urlString: urlString, responseType: GamesResultModel.self) { responseModel, error in
            completion(responseModel, error)
        }
    }
        
    static func getMoreGames(nextPageURL: String, completion: @escaping (GamesResultModel?, Error?) -> Void) {
        let urlString = nextPageURL
        handleResponse(urlString: urlString, responseType: GamesResultModel.self) { responseModel, error in
            completion(responseModel, error)
        }
    }
    
    static func getOrderedGames(orderBy: String, completion: @escaping (GamesResultModel?, Error?) -> Void) {
        let urlString = Keys.apiURL + "?key=" + Keys.apiKEY + "&ordering=" + orderBy
        handleResponse(urlString: urlString, responseType: GamesResultModel.self) { responseModel, error in
            completion(responseModel, error)
        }
    }
    
    static func searchAllGames(gameName:String, completion: @escaping ([GameModel]?, Error?) -> Void) {
        let encodedString = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "*"
        let urlString = Keys.apiURL + "?search_precise=true" + "&search=" + encodedString + "&key=" + Keys.apiKEY
        handleResponse(urlString: urlString, responseType: GamesResultModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }


    static func getGameDetail(gameId: Int, completion: @escaping (GameDetailModel?, Error?) -> Void) {
        let urlString = Keys.apiURL + "/" + String(gameId) + "?key=" + Keys.apiKEY
        handleResponse(urlString: urlString, responseType: GameDetailModel.self, completion: completion)
    }

    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlString).response { response in
            guard let data = response.value else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}

