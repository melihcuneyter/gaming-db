//
//  FeedVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class FeedVC: UIViewController {
    
    var searchController = UISearchController()
    
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
            // TODO: order by name
            print("Users action was tapped")
        }
        
        let orderItemsDate = UIAction(title: "Realese Date", image: UIImage(systemName: "person.badge.plus")) { (action) in
            // TODO: order by date
            print("Add User action was tapped")
        }
        
        let orderItemsRating = UIAction(title: "Rating", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
            // TODO: order by rate
            print("Remove User action was tapped")
        }
        
        let menu = UIMenu(title: "ORDER LIST", options: .displayInline, children: [orderItemsName , orderItemsDate , orderItemsRating])
        
        orderButton.menu = menu
        orderButton.showsMenuAsPrimaryAction = true
        let rightButton = UIBarButtonItem(customView: orderButton)
        navigationItem.rightBarButtonItem = rightButton

    }
}

// MARK: - SearchBar Delegate
extension FeedVC: UISearchBarDelegate {
    
}

