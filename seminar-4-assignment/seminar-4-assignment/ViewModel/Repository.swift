//
//  Repository.swift
//  seminar-4-assignment
//
//  Created by 최성혁 on 2022/11/07.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class Repository {
    struct Constants {
        static let myApiKey = "ec79d7d5a25b0af54c4a226f6a59dafc"
    }
    
    
    
    func popularApiRequest(page: Int, previousPopularMoviesSubject: BehaviorSubject<[MovieModel]>) -> Observable<[MovieModel]>{
        let finalUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(Constants.myApiKey)&language=en-US&page=\(page)"
        
        return Observable.create { emitter in
            AF.request(finalUrl, method: .get).responseData { [weak self] response in
                
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
                    do {
                        try emitter.onNext(previousPopularMoviesSubject.value() + json.results!)
                    } catch {
                        print(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func topRatedApiRequest(page: Int, previousTopRatedMoviesSubject: BehaviorSubject<[MovieModel]>) -> Observable<[MovieModel]> {
        let finalUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(Constants.myApiKey)&language=en-US&page=\(page)"
        
        return Observable.create { emitter in
            AF.request(finalUrl, method: .get).responseData { [weak self] response in
                
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
                    do {
                        try emitter.onNext(previousTopRatedMoviesSubject.value() + json.results!)
                    } catch {
                        print(error)
                    }
                }
            }
            return Disposables.create()
        }
        
        
    }
}
