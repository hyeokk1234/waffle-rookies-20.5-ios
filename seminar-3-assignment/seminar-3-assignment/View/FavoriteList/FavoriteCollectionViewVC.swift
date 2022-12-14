//
//  File.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//Favorite Tab을 눌렀을때 나올 collection view

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FavoriteCollectionViewVC : UIViewController {
    let viewModel : MovieVM
    let collectionView: UICollectionView!
    let disposeBag = DisposeBag()
    
    init(vm: MovieVM) {
        self.viewModel = vm
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: CollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        viewModel.favoritesSubject
            .bind(to: collectionView.rx.items(cellIdentifier: "MovieCollectionViewCell", cellType: MovieCollectionViewCell.self)) { index, item, cell in
            
                cell.setData(item)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.favoritesSubject.onNext(viewModel.favorites)
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

extension FavoriteCollectionViewVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        
        if let image = cell.posterImage.image {
            let movieInfoVC = MovieInfoVC(vm: viewModel, data: viewModel.favorites[indexPath.row], image: image)
            self.navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
}
