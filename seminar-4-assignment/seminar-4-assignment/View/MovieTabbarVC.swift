//
//  MovieTabbarVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit

class MovieTabbarVC : UITabBarController, UITabBarControllerDelegate {
    let viewModel : MovieVM
    let movieTabBarItem: UITabBarItem
    let favoriteTabBarItem: UITabBarItem
    
    init(vm: MovieVM) {
        self.viewModel = vm
        self.movieTabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "m.square.fill"), tag: 1)
        self.favoriteTabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 2)
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setUpTabVC()
    }
    
    func setUpTabVC() {
        let favoriteTab = UINavigationController(rootViewController: FavoriteTabVC(vm: viewModel))
        let movieTab = UINavigationController(rootViewController: MovieTabVC(vm: viewModel))
        
        movieTab.tabBarItem = movieTabBarItem
        favoriteTab.tabBarItem = favoriteTabBarItem
        
        self.viewControllers = [movieTab, favoriteTab]

    }
}
