//
//  MovieTabVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

/* Moview Tab을 눌렀을 때 나올 뷰컨.
 * 평점순, 인기순을 결정할 수 있고 버튼이 눌리면 그에 해당하는 collection view 갈아끼움.
 * 즉, 얘가 parent.
 * child는 PopularCollectionViewVC, TopRatedCollectionViewVC
 */

import Foundation
import UIKit

class MovieTabVC : UIViewController {
    private let viewModel : MovieVM
    
    private let segmentedControl = UISegmentedControl(items: ["Popular", "Top-Rated"])
    
    //인기순 뷰컨
    private var popularVC : PopularCollectionViewVC
    
    //평점순 뷰컨
    private var rateVC : TopRatedCollectionViewVC
    
    private var shouldHidePopularView: Bool? {
        didSet {
          guard let shouldHidePopularView = self.shouldHidePopularView else { return }
            self.popularVC.view.isHidden = shouldHidePopularView
            self.rateVC.view.isHidden = !self.popularVC.view.isHidden
        }
    }
    
    init(vm : MovieVM) {
        self.viewModel = vm
        popularVC = PopularCollectionViewVC(vm: vm)
        rateVC = TopRatedCollectionViewVC(vm: vm)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        sendApiRequest()
    
    }
}

extension MovieTabVC {
    func setUpLayout() {
        self.navigationItem.title = "Movies"
        self.view.addSubview(self.segmentedControl)
        self.segmentedControl.selectedSegmentIndex = 0

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        self.addChild(popularVC)
        self.view.addSubview(popularVC.view)
        popularVC.didMove(toParent: self)
        
        popularVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.popularVC.view.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor, constant: 0),
            self.popularVC.view.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor, constant: 0),
            self.popularVC.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 0),
            self.popularVC.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    
        self.addChild(rateVC)
        self.view.addSubview(rateVC.view)
        rateVC.didMove(toParent: self)
        
        rateVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.rateVC.view.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor, constant: 0),
            self.rateVC.view.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor, constant: 0),
            self.rateVC.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 0),
            self.rateVC.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])

        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        self.didChangeValue(segment: self.segmentedControl)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHidePopularView = segment.selectedSegmentIndex != 0
    }
}

extension MovieTabVC { //API request와 관련된 함수들을 다루는 extension
    func sendApiRequest() {
        viewModel.apiRequestPopular (page: 1) { response in
            self.viewModel.popularMovies = response
        }
        
        viewModel.apiRequestTopRate (page: 1) { response in
            self.viewModel.topRateMovies = response
        }
        
    }

}
