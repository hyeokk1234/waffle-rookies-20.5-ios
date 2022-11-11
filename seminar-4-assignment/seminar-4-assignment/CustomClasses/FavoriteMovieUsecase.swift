//
//  FavoriteUsecase.swift
//  seminar-4-assignment
//
//  Created by 최성혁 on 2022/11/07.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class FavoriteMovieUsecase {
    let disposeBag = DisposeBag()
    var favorites: [MovieModel]
    var favoritesSubject = BehaviorSubject<[MovieModel]>(value: [])
    
    init() {
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
        
        favoriteObservable
            .bind(to: favoritesSubject)
            .disposed(by: disposeBag)
    }
    
    func saveUserDefaults() {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: "favorites")
        }
        UserDefaults.standard.synchronize()
    }
    
    func checkFavoriteExistenceIfExistReturnIndex(movieModel: MovieModel) -> Int? {
        for (index, movie) in favorites.enumerated() {
            if (movie.title == movieModel.title) {
                return index
            }
        }
        return nil
    }
    
    func removeFavoriteAtIndex(index: Int) {
        favorites.remove(at: index)
        saveUserDefaults()
    }
    
    func appendNewFavoriteMovie(movieModel: MovieModel) {
        favorites.append(movieModel)
        saveUserDefaults()
    }
    
    func reloadFavoriteSubject() {
        favoritesSubject.onNext(favorites)
    }
    
    func getFavoriteMovieByIndex(index: Int) -> MovieModel {
        return favorites[index]
    }
}
