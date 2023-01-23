//
//  DetailsVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    @IBOutlet weak var gameIsFavoriteButton: UIButton!
    @IBOutlet weak var gameDescTextView: UITextView!
    @IBOutlet weak var gameRatingLabel: UILabel!
    @IBOutlet weak var gamePlayHours: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var playstationButton: UIButton!
    @IBOutlet weak var xboxButton: UIButton!
    @IBOutlet weak var pcButton: UIButton!
    @IBOutlet weak var nintendoButton: UIButton!
    
    var gameID: Int?
    var gameDetail: GameDetailModel?
    
    var delegateFavorite: FavoritesVC?
    private var viewModel: DetailsVCViewModelProtocol = DetailsVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showError),
                                               name: NSNotification.Name("detailsVCErrorMessage"),
                                               object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isBeingDismissed {
            if Constants.sharedInstance.isFavoriteChanged {
                delegateFavorite?.viewWillAppear(true)
            }
        }
    }
    
    private func setupUI() {
        gameImageView.layer.cornerRadius = 10
        gameImageView.layer.borderWidth = 1
        gameImageView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        gameIsFavoriteButton.tintColor = .red
        navigationController?.navigationBar.prefersLargeTitles = false
        
        gameNameLabel.text = ""
        gameDateLabel.text = ""
        gameRatingLabel.text = ""
        gameDescTextView.text = ""
        gamePlayHours.text = ""
        gameImageView.image = nil
        
        pcButton.isHidden = true
        playstationButton.isHidden = true
        xboxButton.isHidden = true
        nintendoButton.isHidden = true
        
        guard let gameID = gameID else { return }
        
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.fetchGameDetail(gameID)
        
    }
    
    // TODO: fix and update alert
    @objc func showError(_ notification: Notification) {
        if let text = notification.object as? String {
            let alert = UIAlertController(title: NSLocalizedString("ERROR_TITLE", comment: "Error"), message: text, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK_BUTTON", comment: "OK"), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func favoriteHandler(status: Bool?) {
        if let status {
            if status {
                gameIsFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                gameIsFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            gameIsFavoriteButton.isHidden = false
            return
        }
        gameIsFavoriteButton.isHidden = true
        return
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        favoriteHandler(status: viewModel.handleFavorite())
    }
}

extension DetailsVC: DetailsVCViewModelDelegate {
    func gameLoaded() {
        if let gameID = self.gameID {
            favoriteHandler(status: viewModel.isFavoriteGame(gameID))
        }
        
        gameNameLabel.text = viewModel.getGameName()
        gameDescTextView.text = viewModel.getGameDesc()
        gameDateLabel.text = viewModel.getGameInfo()
        gameRatingLabel.text = "\(String(viewModel.getGameRating()))" + " / 5"
        gamePlayHours.text = "\(viewModel.getGamePlayingHours() ?? 0)" + "\(NSLocalizedString("hours", comment: ""))"
        
        let url = URL(string: viewModel.getGameImageUrl() ?? "")
        gameImageView.kf.indicatorType = .activity
        gameImageView.kf.setImage(with: url)
        
        if let platforms = viewModel.getGamePlatforms() {
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
        activityIndicator.stopAnimating()
    }
}
