//
//  FeedVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class FeedVC: UIViewController {
    
    var searchController = UISearchController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        title = "Feed"
        
        // MARK: - SearchBar define
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Aramak istediğiniz oyunu yazın."
        navigationItem.searchController = searchController
        
        setupOrderButton()
    }
    
    private func setupOrderButton() {
        let orderButtonImage = UIImage(systemName: "arrow.up.arrow.down")
        let orderButtonImageSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        let orderButton = UIButton(frame: orderButtonImageSize)
        orderButton.setBackgroundImage(orderButtonImage, for: .normal)
        orderButton.tintColor = .white
        
        let orderItemsName = UIAction(title: "Name", image: UIImage(systemName: "person.fill")) { (action) in
            // TODO: order by name and change image
            print("Users action was tapped")
        }
        
        let orderItemsDate = UIAction(title: "Release Date", image: UIImage(systemName: "person.badge.plus")) { (action) in
            // TODO: order by release date and change image
            print("Add User action was tapped")
        }
        
        let orderItemsRating = UIAction(title: "Rating", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
            // TODO: order by average rating and change image
            print("Remove User action was tapped")
        }
        
        let orderItemsPopularity = UIAction(title: "Popularity", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
            // TODO: order by popularity and change image
            print("Remove User action was tapped")
        }
        
        let menu = UIMenu(title: "ORDER LIST", options: .displayInline, children: [orderItemsName, orderItemsDate, orderItemsRating, orderItemsPopularity])
        
        orderButton.menu = menu
        orderButton.showsMenuAsPrimaryAction = true
        let rightButton = UIBarButtonItem(customView: orderButton)
        navigationItem.rightBarButtonItem = rightButton

    }
}

// MARK: - SearchBar Delegate
extension FeedVC: UISearchBarDelegate {
    
}

// MARK: - CollectionView Delegate
extension FeedVC: UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - CollectionView Datasource
extension FeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCVC", for: indexPath)
//        hourlyCell.hourlyWeather = weatherDetail.hourlyWeatherData[indexPath.row]
        return hourlyCell
    }
}

