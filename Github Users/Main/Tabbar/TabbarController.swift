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
        
        let homeVC = HomeViewController()
        
        let favouriteVC = FavouriteViewController()
        
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let favouriteItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        homeVC.tabBarItem = homeItem
        favouriteVC.tabBarItem = favouriteItem
        
        self.setViewControllers([homeVC, favouriteVC], animated: false)
        self.tabBar.backgroundColor = .white
        
    }
}
