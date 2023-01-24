//
//  NoteTVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit

final class NoteTVC: UITableViewCell {
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameNoteTitleLabel: UILabel!
    @IBOutlet weak var gameNoteTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gameImageView.layer.cornerRadius = 10
        gameImageView.layer.borderWidth = 1
        gameImageView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        
        gameNoteTextView.layer.cornerRadius = 10
        gameNoteTextView.layer.borderWidth = 1
        gameNoteTextView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        
        gameNameLabel.underline()
        
    }
    
    func configureCell(_ note: Note) {
        let url = URL(string: note.imageURL ?? Constants.sharedInstance.baseImageURL)
        
        gameNameLabel.text = note.gameName
        gameNoteTitleLabel.text = note.noteTitle?.uppercased()
        gameNoteTextView.text = note.noteDesc
        gameImageView.kf.setImage(with: url)
    }
}
