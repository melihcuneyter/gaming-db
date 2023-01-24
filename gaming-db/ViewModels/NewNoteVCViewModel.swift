//
//  NewNoteVCViewModel.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 23.01.2023.
//

import Foundation

protocol NewNoteVCViewModelProtocol {
    var delegate: NewNoteVCViewModelDelegate? { get set }
    func newNote(note: NoteModel)
    func editNote(note: Note, newNote: NoteModel)
}

protocol NewNoteVCViewModelDelegate: AnyObject {
    func notesLoaded()
}

final class NewNoteVCViewModel: NewNoteVCViewModelProtocol {
    weak var delegate: NewNoteVCViewModelDelegate?
    private var notes = [Note]()
    
    func newNote(note: NoteModel) {
        _ = NoteCoreDataManager.shared.saveNote(noteModel: note)
    }
    
    
    func editNote(note:Note, newNote:NoteModel){
        NoteCoreDataManager.shared.editNote(noteModel: note, newNoteModel: newNote)
    }
}
