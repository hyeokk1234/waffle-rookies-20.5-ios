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
    var popularMovies : [MovieModel] = []
    var popularMoviesOb = PublishSubject<[MovieModel]>()
    
    var topRateMovies : [MovieModel] = []
    var topRateMoviesOb = PublishSubject<[MovieModel]>()
    
    var favorites : [MovieModel] = []
    let myApiKey = "ec79d7d5a25b0af54c4a226f6a59dafc"
    
    init() {
        _ = rxPopularApiRequest()
            .bind(to: popularMoviesOb)
        _ = rxTopRateApiRequest()
            .bind(to: topRateMoviesOb)
    }
    
    func rxPopularApiRequest() -> Observable<[MovieModel]> {
        return Observable.create { emitter in
            self.apiRequestPopular(page: 1) { result in
                if let result = result {
                    self.popularMovies += result
                    emitter.onNext(result)
                }
            }
            return Disposables.create()
        }
    }
    
    func rxTopRateApiRequest() -> Observable<[MovieModel]> {
        return Observable.create { emitter in
            self.apiRequestTopRate(page: 1) { result in
                if let result = result {
                    self.topRateMovies += result
                    emitter.onNext(result)
                }
            }
            return Disposables.create()
        }
    }
    
    //메서드는 GET
    // 주소/movie/popular? 뒤에 query들
    func apiRequestPopular(page: Int, completion: @escaping ([MovieModel]?) -> Void) {
        let finalUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(myApiKey)&language=en-US&page=\(page)"
        
        AF.request(finalUrl, method: .get).responseData { response in
            
            let decoder = JSONDecoder()
            var json : JsonFirstLayer?
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    json = try decoder.decode(JsonFirstLayer.self, from: result)
                } catch {
                    print(String(describing: error))
                }

            default:
                return
            }
            
            if let json = json {
                completion(json.results!)
            }
        }
    }
    
    //메서드는 GET
    // 주소/movie/top_rated? 뒤에 query들
    func apiRequestTopRate(page: Int, completion: @escaping ([MovieModel]?) -> Void) {
        let finalUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(myApiKey)&language=en-US&page=\(page)"
        
        AF.request(finalUrl, method: .get).responseData { response in
            
            let decoder = JSONDecoder()
            var json : JsonFirstLayer?
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    json = try decoder.decode(JsonFirstLayer.self, from: result)
                } catch {
                    print(String(describing: error))
                }

            default:
                return
            }
            
            if let json = json {
                completion(json.results!)
            }
            debugPrint(response)
        }
    }
}
