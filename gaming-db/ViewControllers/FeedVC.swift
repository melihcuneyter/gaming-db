//
//  FeedVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class FeedVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchController = UISearchController()
    
    private var viewModel: FeedVCViewModelProtocol = FeedVCViewModel()
    
    private var orderBy: String!
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.register(.init(nibName: "FeedGameCVC", bundle: nil), forCellWithReuseIdentifier: "FeedGameCVC")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showError),
                                               name: NSNotification.Name("getAllGamesErrorMessage"),
                                               object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        title = "Feed"
        
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Aramak istediğiniz oyunu yazın."
        navigationItem.searchController = searchController
        
        setupGameOrderByButton()
        
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.getAllGames()
        
        collectionView.layoutSubviews()
    }
    
    private func setupGameOrderByButton() {
        // order Button design and setup
        let orderButtonImage = UIImage(systemName: "arrow.up.arrow.down")
        let orderButtonImageSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        let orderButton = UIButton(frame: orderButtonImageSize)
        orderButton.setBackgroundImage(orderButtonImage, for: .normal)
        orderButton.tintColor = .white
        
        let orderItemsAdded = UIAction(title: "Added") { (action) in
            self.orderBy = "-added"
            self.activityIndicator.startAnimating()
            self.viewModel.getOrderedGames(orderBy: self.orderBy)
        }
        
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
        
        let menu = UIMenu(title: "ORDER BY", options: .displayInline, children: [orderItemsRating, orderItemsAdded, orderItemsName, orderItemsDate])
        
        orderButton.menu = menu
        orderButton.showsMenuAsPrimaryAction = true
        let rightButton = UIBarButtonItem(customView: orderButton)
        navigationItem.rightBarButtonItem = rightButton
        
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

// MARK: - SearchBar Delegate
extension FeedVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pendingRequestWorkItem?.cancel() // delay for search
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            if let text = searchBar.text {
                self?.viewModel.searchAllGames(text: text)
                self?.view.endEditing(true)
            }
        }
        
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }
}

// MARK: - CollectionView Datasource - Delegate
extension FeedVC: UICollectionViewDataSource, UICollectionViewDelegate {
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
        // go detailsVC
        let vc = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"DetailsVC") as! DetailsVC
        
        if let gameID = viewModel.getGameID(at: indexPath.row) {
            vc.gameID = gameID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let nextPageURL = viewModel.getMoreGame() // pagination if willDisplay last cells get next page
        
        if indexPath.row == viewModel.getGameCount() - 1 {
            activityIndicator.startAnimating()
            viewModel.getMoreGames(nextPageURL: nextPageURL)
        }
    }
}

// MARK: - CollectionView - FlowLayoutDelegate
extension FeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (collectionView.frame.width - 20) / 2, height: (collectionView.frame.height - 20) / 2) // 2 columns layout all phone display
    }
}

// MARK: -  ViewModel Delegate
extension FeedVC: FeedVCViewModelDelegate {
    func fetchedGames() {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
}
