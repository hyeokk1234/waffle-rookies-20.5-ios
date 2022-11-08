//
//  MovieCollectionViewCell.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieCollectionViewCell : UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"

    var titleLabel = UILabel()
    var rateLabel = UILabel()
    var posterImage = UIImageView()
    var poster_path: String?
    let disposeBag = DisposeBag()
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLayout()
        setUpLabels()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpLayout()
        setUpLabels()
    }
    
    func configure(_ data: MovieModel) {
        titleLabel.text =  data.title
        if let vote_average = data.vote_average {
            rateLabel.text = "\(vote_average)"
        }
        
        if let poster_path = data.poster_path {
            loadImage(from: poster_path)
                .observe(on: MainScheduler.instance)
                .bind(to: posterImage.rx.image)
                .disposed(by: disposeBag)
        }
    }
    
    private func loadImage(from url: String) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: URL(string: "https://image.tmdb.org/t/p/w500" + url)!) { data, _, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                guard let data = data,
                    let image = UIImage(data: data) else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }

                emitter.onNext(image)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func setUpLayout() {
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
        titleLabel.adjustsFontSizeToFitWidth = true
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
    
    private func setUpLabels() {
        titleLabel.textAlignment = .center
        rateLabel.textAlignment = .center
    }
}
