//
//  NotesVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 13.01.2023.
//

import UIKit

class NotesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        title = "Notes"
        
        let addNotesButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNotesButton(_:)))
        navigationItem.rightBarButtonItems = [addNotesButton]
    }
    
    @objc func addNotesButton(_ sender: UIBarButtonItem) {
        
    }
}
