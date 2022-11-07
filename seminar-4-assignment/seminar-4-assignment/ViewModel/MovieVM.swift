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
    
    var favorites: [MovieModel]
    
    var favoritesSubject = BehaviorSubject<[MovieModel]>(value: [])
    
    
    init(movieUsecase: MovieUsecase, favoriteUsecase: FavoriteUsecase) {
        self.movieUsecase = movieUsecase
        self.favoriteUsecase = favoriteUsecase
        
        //favorite관련 ---------------------------------------------------------------
        if let objects = UserDefaults.standard.value(forKey: "favorites") as? Data {
            let decoder = JSONDecoder()
            if let favoritesDecoded = try? decoder.decode(Array.self, from: objects) as [MovieModel] {
                favorites = favoritesDecoded
            } else {
                favorites = [MovieModel]()
            }
        } else {
            favorites = [MovieModel]()
        }
        
        let favoriteObservable = Observable<[MovieModel]>
            .create { emitter in
                emitter.onNext(self.favorites)
            
                return Disposables.create()
            }
        
        _ = favoriteObservable.bind(to: favoritesSubject)
        //---------------------------------------------------------------------------
        
        requestInitialMovieData()
    }
    
    func requestInitialMovieData() {
        movieUsecase.requestPopular(page: popularCallCount)
        movieUsecase.requestTopRated(page: topRateCallCount)
    }
    
    func requestMorePopularMovieData() {
        popularCallCount += 1
        movieUsecase.requestMorePopular(page: popularCallCount)
    }
    
    func requestMoreTopRatedMovieData() {
        topRateCallCount += 1
        movieUsecase.requestMoreTopRated(page: topRateCallCount)
    }
}
