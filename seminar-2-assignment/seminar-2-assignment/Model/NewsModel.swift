//
//  NewsModel.swift
//  seminar-2-assignment
//
//  Created by 최성혁 on 2022/09/27.
//
import UIKit
import Foundation

struct NewsModel : Codable {
    let title : String?
    let originallink : String?
    let link: String?
    let description: String?
    let pubDate : String?
}

struct jsonFirstLayer : Codable {
    let lastBuildDate: String?
    let total: Int?
    let start: Int?
    let display: Int?
    let items: [NewsModel]?
}
