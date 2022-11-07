//
//  MovieUsercase.swift
//  seminar-4-assignment
//
//  Created by 최성혁 on 2022/11/07.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class MovieUsecase {
    let repository : Repository
    
    init(repository : Repository) {
        self.repository = repository
    }
}
