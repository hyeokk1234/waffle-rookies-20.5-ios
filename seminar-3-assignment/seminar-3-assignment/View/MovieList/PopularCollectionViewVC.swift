//
//  popularVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//인기순 눌렀을때 끼워넣을 child view. 얘는 collection view 갖고있음.

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PopularCollectionViewVC : UIViewController {
    private let collectionView: UICollectionView!
    private let viewModel : MovieVM
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

        viewModel.popularMoviesOb
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

extension PopularCollectionViewVC : UIScrollViewDelegate, UICollectionViewDelegate  {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if (position > (collectionView.contentSize.height - 5 - scrollView.frame.size.height)) {
            
            let subject = viewModel.popularMoviesOb
            if (viewModel.paginationFlag) {
                viewModel.apiRequestPopular { result in
                    if let result = result {
                        do {
                            self.viewModel.popularMovies += result
                            try subject.onNext(subject.value() + result)
                        } catch {
                            print("error")
                        }
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        
        if let image = cell.posterImage.image {
            let movieInfoVC = MovieInfoVC(vm: viewModel, data: viewModel.popularMovies[indexPath.row], image: image)
            self.navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
}
