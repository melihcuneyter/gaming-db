//
//  NotesVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class NotesVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.register(.init(nibName: "NoteTVC", bundle: nil), forCellReuseIdentifier: "NoteTVC")
        
    }
    
    private func setupUI() {
        title = "Notes"
        
        setupAddNotesButton()
        
    }
    
    private func setupAddNotesButton() {
        let notesButtonImage = UIImage(systemName: "plus")
        let notesButtonImageSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        let addButton = UIButton(frame: notesButtonImageSize)
        addButton.setBackgroundImage(notesButtonImage, for: .normal)
        addButton.tintColor = .white
        let rightButton = UIBarButtonItem(customView: addButton)
        addButton.addTarget(self, action: #selector(addNotesButton(_:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func addNotesButton(_ sender: UIBarButtonItem) {
        
    }
}

// MARK: - TableView Delegate
extension NotesVC: UITableViewDelegate {
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
extension NotesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTVC", for: indexPath) as! NoteTVC
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

