//
//  MenuCell.swift
//  Isaac's Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/6/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    func configureCell(title: String) {
        titleLbl.text = title
    }
}
