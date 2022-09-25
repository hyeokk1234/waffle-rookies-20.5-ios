//
//  UserInfoModel.swift
//  assignment_0
//
//  Created by 최성혁 on 2022/09/08.
//

import Foundation

struct Info {
    var userName : String
    var userMail : String
    
    init(userName: String, userMail: String) {
        self.userName = userName
        self.userMail = userMail
    }
    
}

class UserInfoModel {
    var userInfo : Info?
    
    init(inputName: String, inputMail: String) {
        userInfo = Info(userName: inputName, userMail: inputMail)
    }
}
