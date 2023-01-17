//
//  FeedGameCVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit
import Kingfisher

class FeedGameCVC: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var playstationButton: UIButton!
    @IBOutlet weak var xboxButton: UIButton!
    @IBOutlet weak var pcButton: UIButton!
    @IBOutlet weak var nintendoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gameImageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        enablePlatform(id: -1)
        gameImageView.image = nil
    }
    
    func configureCell(_ game: GameModel){
        let url = URL(string: game.backgroundImage!)
        
        gameNameLabel.text = game.name
        gameDateLabel.text = gameInfoCreator(game)
        gameImageView.kf.setImage(with: url)
                
        if let platforms = game.parentPlatforms{
            for i in platforms{
                enablePlatform(id: i.platform?.id ?? 0)
            }
        }
    }
    
    // TODO: replace full CVC and functions, and add some information. ADD Another LOGO for platforms..
    private func gameInfoCreator(_ game: GameModel) -> String{
        let dateString = (game.tba ?? false) ? "TBA" : (game.released?.prefix(4) ?? "TBA")
        var genreString = ""
        
        if let genres = game.genres, ((game.genres?.count ?? 0) != 0){
            for i in genres{
                genreString += i.name ?? ""
                genreString += ", "
            }
            genreString.removeLast(2)
        }
        return "\(genreString) "
    }
    
    private func enablePlatform(id:Int){
        switch id {
        case -1:
            pcButton.isHidden = true
            xboxButton.isHidden = true
            playstationButton.isHidden = true
            nintendoButton.isHidden = true
        case 1:
            pcButton.isHidden = false
        case 2:
            playstationButton.isHidden = false
        case 3:
            xboxButton.isHidden = false
        case 7:
            nintendoButton.isHidden = false
        default:
            break
        }
    }
}
