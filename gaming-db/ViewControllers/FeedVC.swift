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
    
    private var viewModel: FeedVCViewModelProtocol = FeedVCViewModel()
    private var orderBy: String!
    
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
        
        // TODO: backgroundImage OPTIONAL and do code review
        let orderItemsName = UIAction(title: "Name") { (action) in
            self.orderBy = "-name"
            self.activityIndicator.startAnimating()
            self.viewModel.getOrderedGames(orderBy: self.orderBy)
        }
        
        let orderItemsDate = UIAction(title: "Release Date") { (action) in
            self.orderBy = "-released"
            self.activityIndicator.startAnimating()
            self.viewModel.getOrderedGames(orderBy: self.orderBy)
        }
        
        let orderItemsRating = UIAction(title: "Rating") { (action) in
            self.orderBy = "-rating"
            self.activityIndicator.startAnimating()
            self.viewModel.getOrderedGames(orderBy: self.orderBy)
        }
        
        let menu = UIMenu(title: "ORDER BY", options: .displayInline, children: [orderItemsName, orderItemsDate, orderItemsRating])
        
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
        let showCellForGame = viewModel.getGame(at: indexPath.row)
        
        DispatchQueue.main.async {
            cell.configureCell(showCellForGame!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: show gamedetail present
        print("melih", indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let nextPageURL = viewModel.getMoreGame()
        if indexPath.row == viewModel.getGameCount() - 1 {
            activityIndicator.startAnimating()
            viewModel.getMoreGames(nextPageURL: nextPageURL)
        }
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
