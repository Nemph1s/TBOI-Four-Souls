//
//  CardCell.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/9/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    var image: UIImage = UIImage() {
        didSet {
            cardImage.image = image
        }
    }
    
    var text: String = String() {
        didSet {
            cardNameLabel.text = text
        }
    }
}
