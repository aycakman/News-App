//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Ayca Akman on 3.05.2023.
//

import Foundation
import UIKit

struct NewsListViewModel {
    let articles : [Article]
    
    func numberOfRowsInSection() -> Int {
        return self.articles.count
    }
    
    func newsAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(articles: article)
    }
}

struct ArticleViewModel {
    let articles : Article

    var author: String? {
        return articles.author
    }

    var title: String? {
        return articles.title
    }

    var description: String? {
        return articles.description
    }

    var url: String? {
        return articles.url
    }

    var urlToImage: String? {
        return articles.urlToImage
    }

    var publishedAt: String? {
        return articles.publishedAt
    }

    var content: String? {
        return articles.content
}
    
    
}


