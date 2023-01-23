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
        title = NSLocalizedString("notesVC_title", comment: "")
        
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
        let vc = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"NewNoteVC") as! NewNoteVC
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate
extension NotesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - TableView DataSource
extension NotesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: no data view
//        if things.count == 0 {
//            self.tableView.setEmptyMessage(NSLocalizedString("nodata_view", comment: ""))
//        } else {
//            self.tableView.restore()
//        }
//        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTVC", for: indexPath) as! NoteTVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

