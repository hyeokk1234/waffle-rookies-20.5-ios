//
//  TodoListViewModel.swift
//  seminar-1-ios-version2
//
//  Created by 최성혁 on 2022/09/19.
//

import Foundation

class TodoListViewModel {
    var tasks : [TaskModel] = []
    
    func append(tm: TaskModel) {
        tasks.append(tm)
    }
    
    func getNum() -> Int {
        return tasks.count
    }
    
    subscript(index: Int) -> TaskModel {
        return tasks[index]
    }
}
