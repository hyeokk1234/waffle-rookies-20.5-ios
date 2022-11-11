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
    
    //한 번에 API 계속 호출되는걸 방지하기 위한 boolean flag
    var isPaginatingPopularMovies = false
    var isPaginatingTopRatedMovies = false
    
    var popularMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    var topRatedMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    
    init(repository : Repository) {
        self.repository = repository
    }
    
    func requestPopular(page: Int) {
        isPaginatingPopularMovies = true
        
        repository.popularApiRequest(page: page, previousPopularMoviesSubject: popularMoviesSubject){
            self.isPaginatingPopularMovies = false
        }
            .bind(to: popularMoviesSubject)
            .disposed(by: disposeBag)
        
    }
    
    func requestTopRated(page: Int) {
        isPaginatingTopRatedMovies = true

        repository.topRatedApiRequest(page: page, previousTopRatedMoviesSubject: topRatedMoviesSubject) {
            self.isPaginatingTopRatedMovies = false
        }
            .bind(to: topRatedMoviesSubject)
            .disposed(by: disposeBag)
    }
    
    func getPopularMovieByIndex(index: Int) -> MovieModel {
        do {
            return try popularMoviesSubject.value()[index]
        } catch {
            return MovieModel(poster_path: nil, title: nil, vote_average: nil, overview: nil)
        }
    }
    
    func getTopRatedMovieByIndex(index: Int) -> MovieModel {
        do {
            return try topRatedMoviesSubject.value()[index]
        } catch {
            return MovieModel(poster_path: nil, title: nil, vote_average: nil, overview: nil)
        }
    }
}
