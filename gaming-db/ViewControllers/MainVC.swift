//
//  MainVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class MainVC: UIViewController {
    
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    
    }
    
    private func setupUI() {
        title = "Gaming Feed"
        
        // MARK: - SearchBar define
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Aramak istediğiniz oyunu yazın."
        navigationItem.searchController = searchController
        
    }
}

// MARK: - SearchBar Delegate
extension MainVC: UISearchBarDelegate {
    
}
