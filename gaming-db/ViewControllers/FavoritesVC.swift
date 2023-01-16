//
//  FavoritesVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var searchController = UISearchController()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        title = "Favorites"
        
        // MARK: - SearchBar define
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Aramak istediğiniz favori oyunu yazın."
        navigationItem.searchController = searchController
        
    }
}

// MARK: - SearchBar Delegate
extension FavoritesVC: UISearchBarDelegate {

}

// MARK: - TableView Delegate
extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
//
//        let vc = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"LocationDetailVC") as! LocationDetailVC
//        let weatherDetail = weatherLocations[indexPath.row]
//        vc.weatherDetail = weatherDetail
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - TableView DataSource
extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTVC", for: indexPath)
//        let weatherDetail = weatherLocations[indexPath.row]
//        cell.currentWeather = weatherDetail
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("Deleted Location")
//
//            self.weatherLocations.remove(at: indexPath.row)
//            self.saveLocations()
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//        }
    }
}
