//
//  View.swift
//  assignment_0
//
//  Created by 최성혁 on 2022/09/08.
//

import Foundation

class LoginViewModel {
    var userInfoModel : UserInfoModel?
    
    func buildModel(userName: String, userMail: String) {
        self.userInfoModel = UserInfoModel(inputName: userName, inputMail: userMail)
    }
    
    func getInfo() -> [String] {
        return [userInfoModel!.userInfo!.userName, userInfoModel!.userInfo!.userMail]
    }
}
