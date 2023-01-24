//
//  NewNoteVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit

class NewNoteVC: UIViewController {

    @IBOutlet weak var gameNoteTitleTextField: UITextField!
    @IBOutlet weak var gameNoteTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    private var viewModel: NewNoteVCViewModelProtocol = NewNoteVCViewModel()
    
    var note: Note?
    
    var gameID: Int?
    var gameName: String?
    var gameImageURL: String?
    
    private var updatedNote: NoteModel?
    weak var delegateNotesVC: NotesVC?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        saveButton.setTitle("saveButtonTitle".localized, for: .normal)
        saveButton.layer.cornerRadius = 10
        
        gameNoteTitleTextField.borderStyle = .roundedRect
        gameNoteTitleTextField.layer.cornerRadius = 10
        gameNoteTitleTextField.placeholder = "notesVC_gameName".localized
        
        gameNoteTextView.layer.cornerRadius = 10
        gameNoteTextView.layer.borderWidth = 1
        gameNoteTextView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
    
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if isValidData() == false {
            presentAlert(title: "empty_error_title".localized, message: "empty_error_desc".localized)
            return
        }
        
        setUpdatedNote()
        
        if let updatedNote {
            if let note {
                viewModel.editNote(note: note, newNote: updatedNote)
            }
            else {
                viewModel.newNote(note: updatedNote)
            }
            
            LocalNotificationManager.shared.sendNotification(title: "\(updatedNote.noteTitle ?? "")", desc: "newNotesVC_localNotification_title".localized)
            Constants.sharedInstance.isNotesChanged = true
            delegateNotesVC?.viewWillAppear(true)
            self.dismiss(animated: true)
        }
    }
    
    private func setUpdatedNote() {
        updatedNote = NoteModel(gameID: Int64(gameID ?? 0), gameName: gameName, imageID: gameImageURL, imageURL: gameImageURL, noteDesc: gameNoteTextView.text, noteTitle: gameNoteTitleTextField.text)
    }
    
    private func isValidData() -> Bool? {
        if (gameNoteTitleTextField.text == nil || gameNoteTitleTextField.text == "" || gameNoteTextView.text == nil || gameNoteTextView.text == "") {
            return false
        } else {
            return true
        }
    }
}
