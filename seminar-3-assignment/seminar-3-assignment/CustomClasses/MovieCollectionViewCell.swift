//
//  MovieCollectionViewCell.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit

class MovieCollectionViewCell : UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"

    var titleLabel = UILabel()
    var rateLabel = UILabel()
    var posterImage = UIImageView()
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpLayout()
        setUpLabel()
    }
    
    func setUpLayout() {
        self.backgroundColor = .gray
        contentView.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.posterImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            self.posterImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            self.posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            self.posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            self.titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            self.titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 5),
        ])
        
        contentView.addSubview(rateLabel)
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.rateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            self.rateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            self.rateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        ])
    }
    
    func setUpLabel() {
        titleLabel.textAlignment = .center
        rateLabel.textAlignment = .center
    }
}
