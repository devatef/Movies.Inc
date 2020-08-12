//
//  ActorCell.swift
//  MoviesInc
//
//  Created by Atef on 8/11/20.
//  Copyright © 2020 Atef. All rights reserved.
//

import UIKit
import Kingfisher

class ActorCell: UICollectionViewCell {
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var charachterNameLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    
    func configureCellWith(actor:ActorModel) {
        actorNameLabel.text = actor.name
        charachterNameLabel.text = actor.character
        if let path = actor.getImageUrl() , let url = URL(string: path) {
              actorImageView.kf.setImage(with: url, placeholder: UIImage(named: "default"))
        }
      
    }
}
