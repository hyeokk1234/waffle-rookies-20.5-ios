//
//  MovieVM.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit
import Alamofire
import RxSwift

class MovieVM {
    let movieUsecase : MovieUsecase
    let favoriteMovieUsecase: FavoriteMovieUsecase
    
    var popularCallCount : Int = 1
    var topRatedCallCount : Int = 1
    
    
    var popularMovieDataSource: Observable<[MovieModel]> {
        return movieUsecase.popularMoviesSubject.asObservable()
    }
    var topRatedMovieDataSource: Observable<[MovieModel]> {
        return movieUsecase.topRatedMoviesSubject.asObservable()
    }
    var favoriteMovieDataSource: Observable<[MovieModel]> {
        return favoriteMovieUsecase.favoritesSubject.asObservable()
    }
    
    init(movieUsecase: MovieUsecase, favoriteMovieUsecase: FavoriteMovieUsecase) {
        self.movieUsecase = movieUsecase
        self.favoriteMovieUsecase = favoriteMovieUsecase
        requestInitialData()
    }
    
    func requestInitialData() {
        movieUsecase.requestPopular(page: popularCallCount)
        movieUsecase.requestTopRated(page: topRatedCallCount)
    }
    
    func requestMorePopularMovieData() {
        guard !movieUsecase.isPaginatingPopularMovies else {
            return
        }
        popularCallCount += 1
        movieUsecase.requestPopular(page: popularCallCount)
    }
    
    func requestMoreTopRatedMovieData() {
        guard !movieUsecase.isPaginatingTopRatedMovies else {
            return
        }
        topRatedCallCount += 1
        movieUsecase.requestTopRated(page: topRatedCallCount)
    }
    
    
}

// favorite 관련 메서드들
extension MovieVM {
    func reloadFavoriteSubject() {
        favoriteMovieUsecase.reloadFavoriteSubject()
    }
}
