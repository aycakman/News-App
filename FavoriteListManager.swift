//
//  FavoriteListManager.swift
//  NewsApp
//
//  Created by Ayca Akman on 7.05.2023.
//

import Foundation

class FavoriteListManager {
    static let shared = FavoriteListManager()

    private let favoritesKey = "favoriteArticles"

    func saveFavoriteArticle(favoriteArticle: Article) {
        var favoriteArticles = getFavoriteArticles()

        if !favoriteArticles.contains(where: { $0.title == favoriteArticle.title && $0.url == favoriteArticle.url }) {
            favoriteArticles.append(favoriteArticle)

            do {
                let encodedData = try JSONEncoder().encode(favoriteArticles)
                UserDefaults.standard.set(encodedData, forKey: favoritesKey)
            } catch {
                print("error")
            }
        }
    }

    func getFavoriteArticles() -> [Article] {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            do {
                let decodedData = try JSONDecoder().decode([Article].self, from: data)
                return decodedData
            } catch {
                print("error")
            }
        }
        return []
    }

    func removeFavoriteArticle(at index: Int) {
        var favoriteArticles = getFavoriteArticles()
        favoriteArticles.remove(at: index)

        do {
            let encodedData = try JSONEncoder().encode(favoriteArticles)
            UserDefaults.standard.set(encodedData, forKey: favoritesKey)
        } catch {
            print("Unable to remove favorite article.")
        }
    }
}
