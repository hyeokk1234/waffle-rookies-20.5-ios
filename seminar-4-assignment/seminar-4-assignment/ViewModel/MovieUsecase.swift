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
    
    var popularMovies : [MovieModel] = []
    var topRatedMovies : [MovieModel] = []
    
    //한 번에 API 계속 호출되는걸 방지하기 위한 boolean flag
    var paginationFlag = true
    
    var popularMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    var topRatedMoviesSubject = BehaviorSubject<[MovieModel]>(value: [])
    
    init(repository : Repository) {
        self.repository = repository
    }
    
    func requestPopular(page: Int) {
//        if (paginationFlag) {
        paginationFlag = false;
        repository.popularApiRequest(page: page, previousPopularMoviesSubject: popularMoviesSubject)
        .bind(to: popularMoviesSubject)
        .disposed(by: disposeBag)
//            DispatchQueue.main.async {
//                self.paginationFlag = true;
//            }
//        }
        
    }
    
    func requestTopRated(page: Int) {
//        if (paginationFlag) {
//            paginationFlag = false;
            repository.topRatedApiRequest(page: page, previousTopRatedMoviesSubject: topRatedMoviesSubject)
                .bind(to: topRatedMoviesSubject)
                .disposed(by: disposeBag)
//            DispatchQueue.main.async {
//                self.paginationFlag = true;
//            }
//        }
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
