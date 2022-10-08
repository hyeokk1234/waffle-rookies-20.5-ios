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
    let url = "https://api.themoviedb.org/3/movie/"
    let myApiKey = "ec79d7d5a25b0af54c4a226f6a59dafc"
    
    //메서드는 GET
    // 주소/movie/popular? 뒤에 query들
    func apiRequestPopular(page: Int, completion: @escaping ([MovieModel]) -> Void) {
        
    }
    
    //메서드는 GET
    // 주소/movie/top_rated? 뒤에 query들
    func apiRequestTopRate(page: Int, completion: @escaping ([MovieModel]) -> Void) {
        
    }
}
