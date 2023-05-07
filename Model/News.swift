//
//  News.swift
//  NewsApp
//
//  Created by Ayca Akman on 3.05.2023.
//

import Foundation
// MARK: - News
struct News : Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
}
// MARK: - Article
struct Article: Decodable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init(title: String?, url: String?) {
        self.title = title
        self.url = url
        self.author = nil
        self.description = nil
        self.source = nil
        self.publishedAt = nil
        self.urlToImage = nil
        self.content = nil
    }
}

// MARK: - Source
struct Source: Decodable {
    let id: String?
    let name: String?
}

