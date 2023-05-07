//
//  FavoriteListViewController.swift
//  NewsApp
//
//  Created by Ayca Akman on 6.05.2023.
//

import UIKit

class FavoriteListViewController: UIViewController{
    
    @IBOutlet weak var favoriteTableView: UITableView!

    var selectedTitle: String?
    var selectedUrl: String?

    var favoriteArticles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        // Do any additional setup after loading the view.
        loadFavoriteArticles()

    }
    
    func loadFavoriteArticles() {
        favoriteArticles = FavoriteListManager.shared.getFavoriteArticles()
        favoriteTableView.reloadData()
    }

}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "favoriteListCell", for: indexPath) as! FavoriteListTableViewCell

        let favoriteArticle = favoriteArticles[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = favoriteArticle.title
        content.secondaryText = favoriteArticle.url
        cell.contentConfiguration = content
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArticles.count
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           FavoriteListManager.shared.removeFavoriteArticle(at: indexPath.row)
           favoriteArticles.remove(at: indexPath.row)
           favoriteTableView.deleteRows(at: [indexPath], with: .fade)
       }
    }

}
