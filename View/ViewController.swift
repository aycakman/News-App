//
//  ViewController.swift
//  NewsApp
//
//  Created by Ayca Akman on 3.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private var newsListViewModel : NewsListViewModel!
    private let newsService = NewsService()
    
    var selectedRowIndex : Int?
    var filterNews : [Article]?

    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    
        searchBar.delegate = self

        title = "NEWS"

        pullToRefresh()
        getData()
    }
    
    
    @IBAction func favoriteListButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toPressFavoriteListButton", sender: nil)
    }
    
    func pullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func refresh() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
           filterNews = newsListViewModel.articles.filter { article in
               article.title?.localizedCaseInsensitiveContains(searchText) ?? false
           }
       } else {
           filterNews = newsListViewModel.articles
       }
       tableView.reloadData()
    }
    
    func valueForAPIKey(named keyname:String) -> String {
      let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")
      let plist = NSDictionary(contentsOfFile:filePath!)
      let value = plist?.object(forKey: keyname) as! String
      return value
    }
    
    func getData() {
        let url = URL(string: valueForAPIKey(named: "API_KEY"))!
        newsService.downloadNews(url: url) { news in
            if let news = news {
                self.newsListViewModel = NewsListViewModel(articles: news.articles ?? [])
                self.filterNews = self.newsListViewModel.articles
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "toGoDetails", sender: nil)
        searchBar.text = ""
        getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toGoDetails",
              let destinationVC = segue.destination as? DetailsViewController
        else{
            return
        }
        
        if let selectedRowIndex = selectedRowIndex {
            let articleViewModel = self.newsListViewModel.newsAtIndex(selectedRowIndex)
            destinationVC.selectedTitle = articleViewModel.title
            destinationVC.selectedUrl = articleViewModel.url
            destinationVC.selectectAuthor = articleViewModel.author
            destinationVC.selectedContent = articleViewModel.content
            destinationVC.selectedDescription = articleViewModel.description
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterNews?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        var content = cell.defaultContentConfiguration()
        
        if let article = filterNews?[indexPath.row] {
            content.text = article.title
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
    

}

