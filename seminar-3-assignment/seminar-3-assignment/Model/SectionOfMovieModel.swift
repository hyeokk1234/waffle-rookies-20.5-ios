//
//  SectionOfMovieModel.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/09.
//

import Foundation
import RxDataSources

struct SectionOfMovieModel {
    var items: [Item]
}

extension SectionOfMovieModel : SectionModelType {
    typealias Item = MovieModel
    
    init(original: SectionOfMovieModel, items: [Item]) {
        self = original
        self.items = items
    }
}
