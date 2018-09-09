//
//  UIViewRoundCorners.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/9/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class UIViewRoundCorners: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 15.0
    }

}
