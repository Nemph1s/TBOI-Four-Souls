//
//  CloseupCardView.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/11/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class CloseupCardView: UIView {

    @IBOutlet weak var cardImage: UIImageView!
    
    var image: UIImage = UIImage() {
        didSet {
            cardImage.image = image
        }
    }
}
