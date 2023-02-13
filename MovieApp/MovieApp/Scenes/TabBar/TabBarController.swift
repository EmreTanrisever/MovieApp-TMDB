//
//  TabBarController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 13.02.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
     }
}

extension TabBarController {
    
    func configure() {
        configureTabBar()
    }
    
    private func configureTabBar() {
        let home = UINavigationController(rootViewController: HomeController())
        home.title = "TabBar.home".localized
        home.tabBarItem.image = UIImage(systemName: "film")
        home.tabBarItem.selectedImage = UIImage(systemName: "film.fill")
        
        let discover = UINavigationController(rootViewController: DiscoverController())
        discover.title = "TabBar.discover".localized
        discover.tabBarItem.image = UIImage(systemName: "sun.max.circle")
        discover.tabBarItem.selectedImage = UIImage(systemName: "sun.max.circle.fill")
        
        let bookmark = UINavigationController(rootViewController: BookmarkController())
        bookmark.title = "TabBar.bookmark".localized
        bookmark.tabBarItem.image = UIImage(systemName: "bookmark")
        bookmark.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
        
        
        setViewControllers([home, discover, bookmark], animated: false)
        self.modalPresentationStyle = .fullScreen
        tabBar.backgroundColor = .white
    }
}
