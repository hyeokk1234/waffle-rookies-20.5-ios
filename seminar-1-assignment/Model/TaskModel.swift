//
//  TaskModel.swift
//  seminar-1-ios-version2
//
//  Created by 최성혁 on 2022/09/19.
//

import Foundation

class TaskModel : Codable {
    let content: String?
    var isDone: Bool?
    
    init(content: String?, isDone: Bool?) {
        self.content = content
        self.isDone = isDone
    }
}
