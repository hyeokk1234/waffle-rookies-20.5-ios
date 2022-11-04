//
//  FavoriteTabVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//Favorite Tab을 눌렀을 때 나올 뷰컨

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FavoriteTabVC : UIViewController {
    let viewModel : MovieVM
    let favoriteVC : FavoriteCollectionViewVC
    
    init(vm : MovieVM) {
        self.viewModel = vm
        favoriteVC = FavoriteCollectionViewVC(vm: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
}

extension FavoriteTabVC {
    func setUpLayout() {
        self.navigationItem.title = "Favorites"
        
        self.addChild(favoriteVC)
        self.view.addSubview(favoriteVC.view)

        favoriteVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.favoriteVC.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            self.favoriteVC.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            self.favoriteVC.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.favoriteVC.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        favoriteVC.didMove(toParent: self)

    }
}
