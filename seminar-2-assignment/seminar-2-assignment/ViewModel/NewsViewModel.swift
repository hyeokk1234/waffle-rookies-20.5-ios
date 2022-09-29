//
//  NewsViewModel.swift
//  seminar-2-assignment
//
//  Created by 최성혁 on 2022/09/27.
//
import UIKit
import Foundation
import Alamofire

class NewsViewModel {
    //[NewsModel] 관리.
    var news : [NewsModel] = []
    let urlStr = "https://openapi.naver.com/v1/search/news.json"
    let headers: HTTPHeaders = [
        "X-Naver-Client-Id" : "IOCimU2gkN4RCy0fvTHc",
        "X-Naver-Client-Secret" : "ms7B59BObZ"
    ]
    
    func sendRequest(keyword: String) {
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let finalUrlStr = urlStr + "?query=" + encodedKeyword + "&display=20"
        
        AF.request(finalUrlStr, method: .get, headers: headers).responseData { response in
            
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(jsonFirstLayer.self, from: result)
                    self.news = json.items!
                } catch {
                    print("\n\n&&&&&&&&&&&&&&&&&&&\n JSON 파싱 에러 \n&&&&&&&&&&&&&&&&&&&\n\n")
                    print(String(describing: error))
                    print("\n")
                }
                
            default :
                return
            }
            debugPrint(response)
        }
    }
}
