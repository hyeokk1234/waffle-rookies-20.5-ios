//
//  NewsTableCell.swift
//  seminar-2-assignment
//
//  Created by 최성혁 on 2022/09/27.
//

import Foundation
import UIKit


class NewsTableCell : UITableViewCell {
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override var reuseIdentifier: String? {
        return "TableViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TableViewCell")
        
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -150)
        ])
        
        self.contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
        
    }
    
    func configure(title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
