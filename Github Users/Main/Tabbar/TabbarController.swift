//
//  ViewController.swift
//  Github Users
//
//  Created by Oko-osi Korede on 27/10/2022.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabs()
        // Do any additional setup after loading the view.
    }
    
    func tabs() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.setupNavBar()
        
        let favouriteVC = UINavigationController(rootViewController: FavouriteViewController())
        favouriteVC.setupNavBar()
        
        
        let homeItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.3"), tag: 0)
        let favouriteItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        homeVC.tabBarItem = homeItem
        favouriteVC.tabBarItem = favouriteItem
        
        self.setViewControllers([homeVC, favouriteVC], animated: false)
        self.tabBar.backgroundColor = .white
        
    }
}
