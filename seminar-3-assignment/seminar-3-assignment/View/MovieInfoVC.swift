//
//  MovieInfoVC.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

// 영화의 자세한 정보를 띄우는 뷰컨.
// 영화 눌렀을 때 navigation 에 의해 띄워짐.

import Foundation
import UIKit

class MovieInfoVC : UIViewController {
    let posterImage = UIImageView()
    let titleLabel = UILabel()
    let rateLabel = UILabel()
    let overviewLabel = UILabel()
    
    init(data : MovieModel, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = data.title
        if let vote_average = data.vote_average {
            rateLabel.text = "\(vote_average)"
        }
        posterImage.image = image
        overviewLabel.text = data.overview
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        
    }
    
    func setUpLayout() {
        self.view.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.posterImage.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            self.posterImage.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.posterImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.posterImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
        ])
        
        self.view.addSubview(titleLabel)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            self.titleLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.titleLabel.topAnchor.constraint(equalTo: self.posterImage.bottomAnchor, constant: 10),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -270),
        ])
        
        self.view.addSubview(rateLabel)
        rateLabel.adjustsFontSizeToFitWidth = true
        rateLabel.textAlignment = .center
        rateLabel.sizeToFit()
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.rateLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            self.rateLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.rateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.rateLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -240),
        ])
        
        self.view.addSubview(overviewLabel)
        overviewLabel.adjustsFontSizeToFitWidth = true
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .center
        overviewLabel.sizeToFit()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.overviewLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            self.overviewLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.overviewLabel.topAnchor.constraint(equalTo: self.rateLabel.bottomAnchor, constant: 10),
            self.overviewLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
}
