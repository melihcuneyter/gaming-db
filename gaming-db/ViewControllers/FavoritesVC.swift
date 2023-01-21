//
//  FavoritesVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
        
    private var viewModel: FavoritesVCViewModelProtocol = FavoritesVCViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.register(.init(nibName: "FavoriteGameTVC", bundle: nil), forCellReuseIdentifier: "FavoriteGameTVC")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showError),
                                               name: NSNotification.Name("favoriteGamesErrorMessage"),
                                               object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Constants.sharedInstance.isFavoriteChanged {
            activityIndicator.startAnimating()
            viewModel.fetchFavoriteGames()
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        title = "Favorites"
        
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.fetchFavoriteGames()
        
        Constants.sharedInstance.isFavoriteChanged = false
    }
    
    // TODO: fix and update alert
    @objc func showError(_ notification: Notification) {
        if let text = notification.object as? String {
            let alert = UIAlertController(title: NSLocalizedString("ERROR_TITLE", comment: "Error"), message: text, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK_BUTTON", comment: "OK"), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - TableView Delegate
extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"DetailsVC") as! DetailsVC
        
        if let gameID = viewModel.getGameID(at: indexPath.row) {
            vc.gameID = gameID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - TableView DataSource
extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteGameTVC", for: indexPath) as! FavoriteGameTVC
        
        let showCellForGame = viewModel.getGame(at: indexPath.row)
        
        DispatchQueue.main.async {
            cell.configureCell(showCellForGame!)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeGame(at: indexPath.row)
        }
    }
}

extension FavoritesVC: FavoritesVCViewModelDelegate {
    func favoritesFetched() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

