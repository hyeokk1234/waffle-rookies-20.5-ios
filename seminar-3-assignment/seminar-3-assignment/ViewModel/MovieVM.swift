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
    //한 번에 API 계속 호출되는걸 방지하기 위한 boolean flag
    var paginationFlag = true
    
    var popularCallCount : Int = 1
    var topRateCallCount : Int = 1
    
    var popularMovies : [MovieModel] = []
    var popularMoviesOb = BehaviorSubject<[MovieModel]>(value: [])
    
    var topRateMovies : [MovieModel] = []
    var topRateMoviesOb = BehaviorSubject<[MovieModel]>(value: [])
    
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
            self.apiRequestPopular { result in
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
            self.apiRequestTopRate { result in
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
    func apiRequestPopular(completion: @escaping ([MovieModel]?) -> Void) {
        self.paginationFlag = false
        let page = self.popularCallCount
        
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
                self.paginationFlag = true
                self.popularCallCount+=1
                completion(json.results!)
            }
        }
    }
    
    //메서드는 GET
    // 주소/movie/top_rated? 뒤에 query들
    func apiRequestTopRate(completion: @escaping ([MovieModel]?) -> Void) {
        self.paginationFlag = false
        let page = self.topRateCallCount
        
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
                self.paginationFlag = true
                self.topRateCallCount += 1
                completion(json.results!)
            }
        }
    }
}
