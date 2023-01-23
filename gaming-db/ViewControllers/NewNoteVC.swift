//
//  NewNoteVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit

class NewNoteVC: UIViewController {

    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var gameNoteTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.setTitle(NSLocalizedString("saveButtonTitle", comment: ""), for: .normal)
        saveButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
    }
}
