//
//  MovieTabbarVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//기본이 되는 tabbar 뷰컨

import Foundation
import UIKit

class MovieTabbarVC : UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let vm = MovieVM()
                
        let movieTab = UINavigationController(rootViewController: MovieTabVC(vm: vm))
        let movieTabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "m.square.fill"), tag: 1)
        movieTab.tabBarItem = movieTabBarItem
                
        let favoriteTab = UINavigationController(rootViewController: FavoriteTabVC(vm: vm))
        let favoriteTabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 2)
        favoriteTab.tabBarItem = favoriteTabBarItem
        
        self.viewControllers = [movieTab, favoriteTab]
    }
    
}
