//
//  MovieTabVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

//Moview Tab을 눌렀을 때 나올 뷰컨.
//header에서 평점순, 인기순을 결정할 수 있고 버튼이 눌리면 그에 해당하는 collection view 갈아끼움.

import Foundation
import UIKit

class MovieTabVC : UIViewController {
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Popular", "Top-Rated"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    //first가 인기순
    let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //second가 평점순
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var shouldHideFirstView: Bool? {
      didSet {
        guard let shouldHideFirstView = self.shouldHideFirstView else { return }
        self.firstView.isHidden = shouldHideFirstView
        self.secondView.isHidden = !self.firstView.isHidden
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
}

extension MovieTabVC {
    func setUpLayout() {
        self.navigationItem.title = "Movies"

        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.firstView)
        self.view.addSubview(self.secondView)
            
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 50),
        ])
        NSLayoutConstraint.activate([
            self.firstView.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor),
            self.firstView.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor),
            self.firstView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            self.firstView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 10),
        ])
        NSLayoutConstraint.activate([
            self.secondView.leftAnchor.constraint(equalTo: self.firstView.leftAnchor),
            self.secondView.rightAnchor.constraint(equalTo: self.firstView.rightAnchor),
            self.secondView.bottomAnchor.constraint(equalTo: self.firstView.bottomAnchor),
            self.secondView.topAnchor.constraint(equalTo: self.firstView.topAnchor),
        ])
            
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
            
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
    }

    @objc private func didChangeValue(segment: UISegmentedControl) {
      self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
}
