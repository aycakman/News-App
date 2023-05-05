//
//  ViewController.swift
//  NewsApp
//
//  Created by Ayca Akman on 3.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    private var newsListViewModel : NewsListViewModel!
    private let newsService = NewsService()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        getData()
        
    }

    @objc func refresh() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsListViewModel == nil ? 0 : self.newsListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        let articleViewModel = self.newsListViewModel.newsAtIndex(indexPath.row)
        
        cell.articleTitleLabel.text = articleViewModel.title
        return cell
    }
    

}

