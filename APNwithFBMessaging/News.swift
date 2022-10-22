//
//  News.swift
//  APNwithFBMessaging
//
//  Created by fyz on 10/22/22.
//

import Foundation

class News {
    var title: String
    var description: String
    
    init(title: String, description: String){
        self.title = title
        self.description = description
    }
}
class NewsFeed{
    static let shared = NewsFeed()
    var newsFeed: [News] = []

    func addNews(news: News) {
        newsFeed.append(news)
    }
}
