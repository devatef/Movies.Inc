//
//  MovieCell.swift
//  MoviesInc
//
//  Created by Atef on 8/9/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureWith(item: Movie) {
         posterImageView.kf.setImage(with: URL(string:item.getImageUrl() ), placeholder: UIImage(named: "default"))
         titleLabel.text = item.title
         dateLabel.text = item.release_date
         voteLabel.text = "\(item.vote_average)"
       }
}
