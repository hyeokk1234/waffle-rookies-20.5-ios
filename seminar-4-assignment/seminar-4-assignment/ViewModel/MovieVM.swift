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
    let favoriteUsecase: FavoriteUsecase
    
    var popularCallCount : Int = 1
    var topRateCallCount : Int = 1
    
    var popularMovieDataSource: Observable<[MovieModel]> {
        return movieUsecase.popularMoviesSubject.asObservable()
    }
    var topRatedMovieDataSource: Observable<[MovieModel]> {
        return movieUsecase.topRatedMoviesSubject.asObservable()
    }
    var favoriteMovieDataSource: Observable<[MovieModel]> {
        return favoriteUsecase.favoritesSubject.asObservable()
    }
    
    init(movieUsecase: MovieUsecase, favoriteUsecase: FavoriteUsecase) {
        self.movieUsecase = movieUsecase
        self.favoriteUsecase = favoriteUsecase
        
        requestInitialMovieData()
    }
    
    func requestInitialMovieData() {
        movieUsecase.requestPopular(page: popularCallCount)
        movieUsecase.requestTopRated(page: topRateCallCount)
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
        topRateCallCount += 1
        movieUsecase.requestTopRated(page: topRateCallCount)
    }
    
    func getPopularMovieByIndex(index: Int) -> MovieModel {
        return movieUsecase.getPopularMovieByIndex(index: index)
    }
    
    func getTopRatedMovieByIndex(index: Int) -> MovieModel {
        return movieUsecase.getTopRatedMovieByIndex(index: index)
    }
}

// favorite 관련 메서드들
extension MovieVM {
    func getFavoriteMovieByIndex(index: Int) -> MovieModel {
        return favoriteUsecase.getFavoriteMovieByIndex(index: index)
    }
    
    func checkFavoriteExistenceIfExistReturnIndex(movieModel: MovieModel) -> Int? {
        return favoriteUsecase.checkFavoriteExistenceIfExistReturnIndex(movieModel: movieModel)
    }
    
    func removeFavoriteAtIndex(index: Int) {
        favoriteUsecase.removeFavoriteAtIndex(index: index)
    }
    
    func appendNewFavoriteMovie(movieModel: MovieModel) {
        favoriteUsecase.appendNewFavoriteMovie(movieModel: movieModel)
    }
    
    func reloadFavoriteSubject() {
        favoriteUsecase.reloadFavoriteSubject()
    }
}
