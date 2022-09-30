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
    let month = ["Jan" : "1월", "Feb" : "2월", "Mar" : "3월", "Apr" : "4월", "May" : "5월", "Jun" : "6월", "Jul" : "7월", "Aug" : "8월", "Sep" : "9월", "Oct" : "10월", "Nov" : "11월", "Dec" : "12월"]
    
    func sendRequest(keyword: String, completion: @escaping ([NewsModel]) -> Void) {
        //start:검색 시작 위치. 기본값은 1
        let start = 1
        
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let finalUrlStr =
        urlStr + "?query=" + encodedKeyword + "&display=20" + "&start=" + String(start)
        
        AF.request(finalUrlStr, method: .get, headers: self.headers).responseData { response in
            
            let decoder = JSONDecoder()
            var json : jsonFirstLayer?
            
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                                
                do {
                    json = try decoder.decode(jsonFirstLayer.self, from: result)
                } catch {
                    print(String(describing: error))
                }
                
            default :
                return
            }
            
            if let json = json {
                completion(json.items!)
            }
            debugPrint(response)
        }
    }
    
    func getNum() -> Int {
        return news.count
    }
    
    func getTitle(index: Int) -> String {
        return news[index].title!.htmlEscaped
    }
    
    func getDate(index: Int) -> String {
        let pubDate = news[index].pubDate!
        let seperatedDate = pubDate.split(separator: " ")
        let parsedDate = seperatedDate[3] + "년 " + month[String(seperatedDate[2])]! + " " + seperatedDate[1] + "일"
        return String(parsedDate)
    }
}

extension String {
    // html 태그 제거 + html entity들 디코딩.
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData,
                                                    options: options,
                                                    documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}
