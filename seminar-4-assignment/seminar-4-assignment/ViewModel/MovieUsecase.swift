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
    let repository : Repository
        
    var popularMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    
    var topRateMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    
    
    init(repository : Repository) {
        self.repository = repository
    }
    
    func requestPopular(page: Int) {
        _ = repository.popularApiRequest(page: page)
            .bind(to: popularMoviesSubject)
    }
    
    func requestTopRated(page: Int) {
        _ = repository.topRateApiRequest(page: page)
            .bind(to: topRateMoviesSubject)
    }
    
    func requestMorePopular(page: Int) {
        
    }
    
    func requestMoreTopRated(page: Int) {
        
    }
    
}
