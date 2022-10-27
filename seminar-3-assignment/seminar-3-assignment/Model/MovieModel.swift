//
//  movieModel.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit

class MovieModel: Codable {
    let poster_path: String?
    let title: String?
    let vote_average: Double?
    let overview: String?
    var favoriteFlag = false
    
    init(movieDecoder : MovieDecoder) {
        self.poster_path = movieDecoder.poster_path
        self.title = movieDecoder.title
        self.vote_average = movieDecoder.vote_average
        self.overview = movieDecoder.overview
    }
}

struct MovieDecoder: Codable {
    let poster_path: String?
    let title: String?
    let vote_average: Double?
    let overview: String?
}

struct JsonFirstLayer: Codable {
    let page: Int?
    let results: [MovieDecoder]?
}
