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
        
        requestInitialMovieData()
    }
    
    func requestInitialMovieData() {
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
        return favoriteMovieUsecase.getFavoriteMovieByIndex(index: index)
    }
    
    func checkFavoriteExistenceIfExistReturnIndex(movieModel: MovieModel) -> Int? {
        return favoriteMovieUsecase.checkFavoriteExistenceIfExistReturnIndex(movieModel: movieModel)
    }
    
    func removeFavoriteAtIndex(index: Int) {
        favoriteMovieUsecase.removeFavoriteAtIndex(index: index)
    }
    
    func appendNewFavoriteMovie(movieModel: MovieModel) {
        favoriteMovieUsecase.appendNewFavoriteMovie(movieModel: movieModel)
    }
    
    func reloadFavoriteSubject() {
        favoriteMovieUsecase.reloadFavoriteSubject()
    }
}
