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

class FavoriteUsecase {
    var favorites: [MovieModel]
    
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
        
//        _ = favoriteObservable.bind(to: favoritesSubject)
    }
}
