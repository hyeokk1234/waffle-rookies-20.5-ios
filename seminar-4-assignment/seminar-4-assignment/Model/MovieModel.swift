//
//  movieModel.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit

struct MovieModel: Codable {
    let poster_path: String?
    let title: String?
    let vote_average: Double?
    let overview: String?
}

struct JsonFirstLayer: Codable {
    let page: Int?
    let results: [MovieModel]?
}
