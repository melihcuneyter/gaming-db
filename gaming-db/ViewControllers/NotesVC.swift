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
    
    private var viewModel: NotesVCViewModelProtocol = NotesVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.register(.init(nibName: "NoteTVC", bundle: nil), forCellReuseIdentifier: "NoteTVC")
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showError),
                                               name: NSNotification.Name("noteGamesErrorMessage"),
                                               object: nil)
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.fetchNotes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (Constants.sharedInstance.isNotesChanged) {
            viewModel.fetchNotes()
        }
    }
    
    private func setupUI() {
        title = "notesVC_title".localized
        
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
        vc.delegateNotesVC = self
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate
extension NotesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: show editNote
//        let vc = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"NewNoteVC") as! NewNoteVC
//
//        if let note = viewModel.getNote(at: indexPath.row) {
//            vc.note = note
//            vc.modalPresentationStyle = .popover
//            self.present(vc, animated: true, completion: nil)
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - TableView DataSource
extension NotesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.getNoteCount() == 0 {
            self.tableView.setEmptyMessage("nodata_notes_view".localized)
        } else {
            self.tableView.restore()
        }
        return viewModel.getNoteCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTVC", for: indexPath) as! NoteTVC
        
        let showCellForNote = viewModel.getNote(at: indexPath.row)
        DispatchQueue.main.async {
            cell.configureCell(showCellForNote!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete".localized) { (contextualAction, view, bool ) in
            LocalNotificationManager.shared.sendNotification(title: "", desc: "notesVC_localNotification_title".localized)
            self.viewModel.deleteNote(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .left)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesVC: NotesVCViewModelDelegate {
    func notesFetched() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
}
