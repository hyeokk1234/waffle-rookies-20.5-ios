//
//  popularVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//인기순 눌렀을때 끼워넣을 child view. 얘는 collection view 갖고있음.

import Foundation
import UIKit

class PopularCollectionViewVC : UIViewController {
    private var collectionView: UICollectionView!
    private let data = Data()
    private let viewModel : MovieVM
    
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
            registerCollectionView()
            collectionViewDelegate()
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
    
    func registerCollectionView() {
        collectionView.register(MovieCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
    }
        
    func collectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension PopularCollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.memberName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! MovieCollectionViewCell
                cell.memberNameLabel.text = data.memberName[indexPath.row]
        return cell
    }
}
