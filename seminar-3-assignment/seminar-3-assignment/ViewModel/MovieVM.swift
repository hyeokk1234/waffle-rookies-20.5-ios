//
//  MovieVM.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit
import Alamofire

class MovieVM {
    var topRateMovies : [MovieModel] = []
    var popularMovies : [MovieModel] = []
    var favorites : [MovieModel] = []
    let myApiKey = "ec79d7d5a25b0af54c4a226f6a59dafc"
    
    //메서드는 GET
    // 주소/movie/popular? 뒤에 query들
    func apiRequestPopular(page: Int, completion: @escaping ([MovieModel]) -> Void) {
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
            debugPrint(response)
        }
    }
    
    //메서드는 GET
    // 주소/movie/top_rated? 뒤에 query들
    func apiRequestTopRate(page: Int, completion: @escaping ([MovieModel]) -> Void) {
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
