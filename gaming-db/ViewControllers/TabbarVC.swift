//
//  TabbarVC.swift
//  gaming-db
//
//  Created by Melih Cüneyter on 16.01.2023.
//

import UIKit

final class TabbarVC: UITabBarController {
    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbar.items![0].title = "feedVC_title".localized
        tabbar.items![1].title = "favoritesVC_title".localized
        tabbar.items![2].title = "notesVC_title".localized
        
    }
}
