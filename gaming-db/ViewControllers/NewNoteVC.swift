//
//  NewNoteVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit

final class NewNoteVC: UIViewController {
    @IBOutlet weak var gameNoteTitleTextField: UITextField!
    @IBOutlet weak var gameNoteTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    private var viewModel: NewNoteVCViewModelProtocol = NewNoteVCViewModel()
    
    var note: Note?
    
    var gameID: Int?
    var gameName: String?
    var gameImageURL: String?
    
    private var editidNote: NoteModel?
    weak var delegateNotesVC: NotesVC?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        saveButton.setTitle("saveButtonTitle".localized, for: .normal)
        saveButton.layer.cornerRadius = 10
        
        gameNoteTitleTextField.borderStyle = .line
        gameNoteTitleTextField.placeholder = "notesVC_gameName".localized
        
        gameNoteTextView.layer.cornerRadius = 10
        gameNoteTextView.layer.borderWidth = 1
        gameNoteTextView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        
        gameNoteTitleTextField.text = note?.noteTitle ?? ""
        gameNoteTextView.text = note?.noteDesc ?? ""
       
        setAlreadyHaveNotes(note: note)
    
    }
    
    private func setAlreadyHaveNotes(note: Note?) { // when click already note edit
        if let note = note {
            gameID = Int(note.gameID)
            gameName = note.gameName
            gameImageURL = note.imageURL
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if isValidData() == false {
            presentAlert(title: "empty_error_title".localized, message: "empty_error_desc".localized)
            return
        }
        
        setEditidNote()
        
        if let editidNote {
            if let note {
                viewModel.editNote(note: note, newNote: editidNote)
            }
            else {
                viewModel.newNote(note: editidNote)
            }
            
            LocalNotificationManager.shared.sendNotification(title: "\(editidNote.noteTitle ?? "")", desc: "newNotesVC_localNotification_title".localized)
            Constants.sharedInstance.isNotesChanged = true
            delegateNotesVC?.viewWillAppear(true)
            self.dismiss(animated: true)
        }
    }
    
    private func setEditidNote() {
        editidNote = NoteModel(gameID: Int64(gameID ?? 0), gameName: gameName, imageURL: gameImageURL, noteDesc: gameNoteTextView.text, noteTitle: gameNoteTitleTextField.text)
    }
    
    private func isValidData() -> Bool? {
        if (gameNoteTitleTextField.text == nil || gameNoteTitleTextField.text == "" || gameNoteTextView.text == nil || gameNoteTextView.text == "") {
            return false
        } else {
            return true
        }
    }
}
