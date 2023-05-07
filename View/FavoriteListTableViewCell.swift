//
//  FavoriteListTableViewCell.swift
//  NewsApp
//
//  Created by Ayca Akman on 6.05.2023.
//

import UIKit

class FavoriteListTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteUrlLabel: UILabel!
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


