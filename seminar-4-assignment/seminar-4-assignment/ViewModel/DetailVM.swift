//
//  DetailVM.swift
//  seminar-4-assignment
//
//  Created by 최성혁 on 2022/11/11.
//

import Foundation

class DetailVM {
    let movieUsecase: MovieUsecase
    let favoriteMovieUsecase: FavoriteMovieUsecase
    
    var selectedMovieModel: MovieModel?
    
    init(movieUsecase: MovieUsecase, favoriteMovieUsecase: FavoriteMovieUsecase) {
        self.movieUsecase = movieUsecase
        self.favoriteMovieUsecase = favoriteMovieUsecase
    }
    
    func selectPopularMovieByIndex(index: Int) {
        self.selectedMovieModel = movieUsecase.getPopularMovieByIndex(index: index)
    }
    
    func selectTopRatedMovieByIndex(index: Int) {
        self.selectedMovieModel = movieUsecase.getTopRatedMovieByIndex(index: index)
    }
}

extension DetailVM {
    func selectFavoriteMovieByIndex(index: Int) {
        self.selectedMovieModel = favoriteMovieUsecase.getFavoriteMovieByIndex(index: index)
    }
    
    func checkFavoriteExistenceIfExistReturnIndex(movieModel: MovieModel) -> Int? {
        return favoriteMovieUsecase.checkFavoriteExistenceIfExistReturnIndex(movieModel: movieModel)
    }
    
    func removeFavoriteAtIndex(index: Int) {
        favoriteMovieUsecase.removeFavoriteAtIndex(index: index)
    }

    func appendSelectedToFavorites() {
        favoriteMovieUsecase.appendNewFavoriteMovie(movieModel: selectedMovieModel!)
    }
}
