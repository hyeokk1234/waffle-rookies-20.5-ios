//
//  MovieUsercase.swift
//  seminar-4-assignment
//
//  Created by 최성혁 on 2022/11/07.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class MovieUsecase {
    let disposeBag = DisposeBag()
    let repository : Repository
    
    var popularMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    var topRatedMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    
    init(repository : Repository) {
        self.repository = repository
    }
    
    func requestPopular(page: Int) {
        repository.popularApiRequest(page: page)
            .bind(to: popularMoviesSubject)
            .disposed(by: disposeBag)
    }
    
    func requestTopRated(page: Int) {
        repository.topRatedApiRequest(page: page)
            .bind(to: topRatedMoviesSubject)
            .disposed(by: disposeBag)
    }
}
