//
//  FavoriteGameTVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit

final class FavoriteGameTVC: UITableViewCell {
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    @IBOutlet weak var gameRatingLabel: UILabel!
    
    @IBOutlet weak var playstationButton: UIButton!
    @IBOutlet weak var xboxButton: UIButton!
    @IBOutlet weak var pcButton: UIButton!
    @IBOutlet weak var nintendoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gameImageView.layer.cornerRadius = 10
        gameImageView.layer.borderWidth = 1
        gameImageView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        
        gameNameLabel.text = ""
        gameDateLabel.text = ""
        gameRatingLabel.text = ""
        gameImageView.image = nil
        
        pcButton.isHidden = true
        playstationButton.isHidden = true
        xboxButton.isHidden = true
        nintendoButton.isHidden = true
    }
    
    override func prepareForReuse() {
        gameImageView.image = nil
    }
    
    func configureCell(_ game: GameDetailModel) {
        let gameDate = (game.tba ?? false) ? "TBA" : (game.released?.prefix(4) ?? "TBA")
        let url = URL(string: game.backgroundImage ?? Constants.sharedInstance.baseImageURL)
        
        gameNameLabel.text = game.name
        gameDateLabel.text = "\(gameDate)"
        gameRatingLabel.text = String(game.rating)
        gameImageView.kf.setImage(with: url)
        
        if let platforms = game.parentPlatforms {
            for platform in platforms {
                if platform.platform?.name == "PC" {
                    pcButton.isHidden = false
                }
                
                if platform.platform?.name == "PlayStation" {
                    playstationButton.isHidden = false
                }
                
                if platform.platform?.name == "Xbox" {
                    xboxButton.isHidden = false
                }
                
                if platform.platform?.name == "Nintendo" {
                    nintendoButton.isHidden = false
                }
            }
        }
    }
}
