//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let libraryVC = LibraryViewController()
        
        homeVC.title = "Browse"
        searchVC.title = "Search"
        libraryVC.title = "Library"
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        searchVC.navigationItem.largeTitleDisplayMode = .always
        libraryVC.navigationItem.largeTitleDisplayMode = .always
        
        let homeTab = UINavigationController(rootViewController: homeVC)
        let searchTab = UINavigationController(rootViewController: searchVC)
        let libraryTab = UINavigationController(rootViewController: libraryVC)
        
        let tabs = [homeTab, searchTab, libraryTab]
        
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchTab.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        libraryTab.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 1)
        
        tabs.forEach {
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationBar.tintColor = .label
        }
        
        setViewControllers([homeTab, searchTab, libraryTab], animated: false)
    }
}
