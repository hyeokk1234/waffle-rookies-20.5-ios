//
//  FavoriteTabVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//Favorite Tab을 눌렀을 때 나올 뷰컨

import Foundation
import UIKit

class FavoriteTabVC : UIViewController {
    let viewModel : MovieVM
    
    init(vm : MovieVM) {
        self.viewModel = vm
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

    }
}
