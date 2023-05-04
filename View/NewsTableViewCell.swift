//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ayca Akman on 3.05.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleUrlLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
