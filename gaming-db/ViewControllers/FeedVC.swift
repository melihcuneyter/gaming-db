//
//  FeedVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class FeedVC: UIViewController {
    
    var searchController = UISearchController()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var games: [GameModel]?
    private var tempGames: [GameModel]?
    
    private var viewModel: FeedVCViewModelProtocol = FeedVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.register(.init(nibName: "FeedGameCVC", bundle: nil), forCellWithReuseIdentifier: "FeedGameCVC")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showError),
                                               name: NSNotification.Name("getAllGamesErrorMessage"),
                                               object: nil)
        
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.getAllGames()
        
    }
    
    private func setupUI() {
        title = "Feed"
        
        // MARK: - SearchBar define
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Aramak istediğiniz oyunu yazın."
        navigationItem.searchController = searchController
        // TODO: Searchbar change color and fix animation.
        
        setupOrderButton()
    }
    
    private func setupOrderButton() {
        let orderButtonImage = UIImage(systemName: "arrow.up.arrow.down")
        let orderButtonImageSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        let orderButton = UIButton(frame: orderButtonImageSize)
        orderButton.setBackgroundImage(orderButtonImage, for: .normal)
        orderButton.tintColor = .white
        
        let orderItemsName = UIAction(title: "Name") { (action) in
            // TODO: order by name and change image
            print("Users action was tapped")
        }
        
        let orderItemsDate = UIAction(title: "Release Date") { (action) in
            // TODO: order by release date and change image
            print("Add User action was tapped")
        }
        
        let orderItemsRating = UIAction(title: "Rating") { (action) in
            // TODO: order by average rating and change image
            print("Remove User action was tapped")
        }
        
        let orderItemsPopularity = UIAction(title: "Popularity") { (action) in
            // TODO: order by popularity and change image
            print("Remove User action was tapped")
        }
        
        let menu = UIMenu(title: "ORDER BY", options: .displayInline, children: [orderItemsName, orderItemsDate, orderItemsRating, orderItemsPopularity])
        
        orderButton.menu = menu
        orderButton.showsMenuAsPrimaryAction = true
        let rightButton = UIBarButtonItem(customView: orderButton)
        navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @objc func showError(_ notification: Notification) {
        if let text = notification.object as? String {
            let alert = UIAlertController(title: NSLocalizedString("ERROR_TITLE", comment: "Error"), message: text, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK_BUTTON", comment: "OK"), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - SearchBar Delegate
extension FeedVC: UISearchBarDelegate {
    
}

// MARK: - CollectionView Delegate
extension FeedVC: UICollectionViewDelegate {
    
}

// MARK: - CollectionView Datasource
extension FeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getGameCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedGameCVC", for: indexPath) as! FeedGameCVC
        
        let showGameForCell = viewModel.getGame(at: indexPath.row)
        
        DispatchQueue.main.async {
            cell.configureCell(showGameForCell!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: show gamedetail present
    }
}

// MARK: - CollectionView - FlowLayoutDelegate
extension FeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (collectionView.frame.width - 20) / 2, height: (collectionView.frame.height - 20) / 2)
    }
}

// MARK: -  ViewModel Delegate
extension FeedVC: FeedVCViewModelDelegate {
    func fetchedGames() {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
}
