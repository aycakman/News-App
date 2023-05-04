//
//  WebService.swift
//  NewsApp
//
//  Created by Ayca Akman on 3.05.2023.
//

import Foundation

class NewsService {
    
    func downloadNews(url: URL, completion: @escaping (News?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)

            }else if let data = data {
                do {
                    let newsList = try JSONDecoder().decode(News.self, from: data)
                    print(newsList)
                    completion(newsList)

                }catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)

                }
                
            }
            
        }.resume()
    }
}
