//
//  Extensions.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 23.01.2023.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 25)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 25)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}

extension UIViewController {
    @objc func showError(_ notification: Notification) {
        if let text = notification.object as? String {
            let alert = UIAlertController(title: NSLocalizedString("error_title", comment: ""), message: text, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
