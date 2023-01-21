//
//  TabbarVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit

class TabbarVC: UITabBarController {

    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbar.items![0].title = NSLocalizedString("feedVC_title", comment: "")
        tabbar.items![1].title = NSLocalizedString("favoritesVC_title", comment: "")
        tabbar.items![2].title = NSLocalizedString("notesVC_title", comment: "")
        
    }
}
