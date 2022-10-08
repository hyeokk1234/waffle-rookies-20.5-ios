//
//  MovieCollectionViewCell.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit

class MovieCollectionViewCell : UICollectionViewCell {
    var memberNameLabel: UILabel!
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setUpLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setUpLabel()
    }
        
    func setUpCell() {
        memberNameLabel = UILabel()
        contentView.addSubview(memberNameLabel)
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        memberNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        
    func setUpLabel() {
        memberNameLabel.font = UIFont.systemFont(ofSize: 32)
        memberNameLabel.textAlignment = .center
    }
}
