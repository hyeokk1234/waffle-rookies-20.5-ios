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
    let viewModel : MovieVM
    
    init(vm: MovieVM) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
                
        let movieTab = UINavigationController(rootViewController: MovieTabVC(vm: viewModel))
        let movieTabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "m.square.fill"), tag: 1)
        movieTab.tabBarItem = movieTabBarItem
                
        let favoriteTab = UINavigationController(rootViewController: FavoriteTabVC(vm: viewModel))
        let favoriteTabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 2)
        favoriteTab.tabBarItem = favoriteTabBarItem
        
        self.viewControllers = [movieTab, favoriteTab]
    }
    
}
