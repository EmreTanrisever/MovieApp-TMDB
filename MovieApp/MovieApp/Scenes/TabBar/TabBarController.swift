//
//  TabBarController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 13.02.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
     }
}

extension TabBarController {
    
    func configure() {
        title = "AppName".localized
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowColor = UIColor(named: "tabbarshadow")?.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor(named: "tabbaritemcolor") ?? .lightGray],
            for:.normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor(named: "tabbaritemactivecolor") ?? .lightGray],
            for:.selected
        )
        UITabBar.appearance().tintColor = UIColor(named: "tabbaritemactivecolor")
        
        let home = UINavigationController(rootViewController: HomeController())
        home.title = "TabBar.home".localized
        home.tabBarItem.image = UIImage(systemName: "film")
        home.tabBarItem.selectedImage = UIImage(systemName: "film.fill")
        
        let bookmark = UINavigationController(rootViewController: BookmarkController())
        bookmark.title = "TabBar.bookmark".localized
        bookmark.tabBarItem.image = UIImage(systemName: "bookmark")
        bookmark.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
        
        
        setViewControllers([home, bookmark], animated: false)
        self.modalPresentationStyle = .fullScreen
        tabBar.backgroundColor = .white
    }
}
