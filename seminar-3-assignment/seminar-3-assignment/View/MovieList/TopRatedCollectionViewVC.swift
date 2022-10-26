//
//  topRatedVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//평점순으로 눌렀을 때 끼워넣을 child view. 얘는 collection view 갖고있음.

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TopRatedCollectionViewVC : UIViewController {
    private var collectionView: UICollectionView!
    private let viewModel : MovieVM
    let disposeBag = DisposeBag()
    
    init(vm: MovieVM) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: CollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        viewModel.topRateMoviesOb
            .bind(to: collectionView.rx.items(cellIdentifier: "MovieCollectionViewCell", cellType: MovieCollectionViewCell.self)) { index, item, cell in
            
                cell.setData(item)
            }
            .disposed(by: disposeBag)
    }

    func configureCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
}

