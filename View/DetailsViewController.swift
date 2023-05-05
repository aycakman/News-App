//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Ayca Akman on 4.05.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var newsListViewModel : NewsListViewModel!

    var selectedTitle: String?
    var selectedUrl: String?
    var selectectAuthor: String?
    var selectedDescription: String?
    var selectedContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedTitle = selectedTitle {
            titleLabel.text = selectedTitle
        }
        
        if let selectedUrl = selectedUrl {
            urlLabel.text = selectedUrl
        }
        
        if let selectedDescription = selectedDescription {
            descriptionLabel.text = selectedDescription
        }
        
        if let selectectAuthor = selectectAuthor {
            authorLabel.text = selectectAuthor
        }
        
        if let selectedContent = selectedContent {
            contentLabel.text = selectedContent
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
