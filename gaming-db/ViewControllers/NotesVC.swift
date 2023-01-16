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
