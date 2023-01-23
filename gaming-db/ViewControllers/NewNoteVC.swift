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
    
    private var viewModel: NewNoteVCViewModelProtocol = NewNoteVCViewModel()
    
    var note: Note?
    var game: GameModel?
    private var updatedNote: NoteModel?
    weak var delegateNotesVC: NotesVC?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        saveButton.setTitle("saveButtonTitle".localized, for: .normal)
        saveButton.layer.cornerRadius = 10
        
        gameNameTextField.borderStyle = .bezel
        gameNameTextField.layer.cornerRadius = 10
        gameNameTextField.placeholder = "notesVC_gameName".localized
        
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
                viewModel.editNote(obj: note, newObj: updatedNote)
            }
            else {
                viewModel.newNote(obj: updatedNote)
            }
            
            Constants.sharedInstance.isNotesChanged = true
            delegateNotesVC?.viewWillAppear(true)
            self.dismiss(animated: true)
        }
    }
    
    private func setUpdatedNote() {
        updatedNote = NoteModel(gameID: Int64(game?.id ?? 0), imageID: game?.backgroundImage, imageURL: game?.backgroundImage, noteDesc: gameNoteTextView.text, noteTitle: gameNameTextField.text)
    }
    
    private func isValidData() -> Bool? {
        if (gameNameTextField.text == nil || gameNameTextField.text == "" || gameNoteTextView.text == nil || gameNoteTextView.text == "") {
            return false
        } else {
            return true
        }
    }
}
