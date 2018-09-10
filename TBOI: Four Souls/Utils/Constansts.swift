//
//  Constansts.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/10/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import Foundation
import CoreGraphics

extension UserDefaults {
    
    enum ID {
        
        static let CardCellReuseIdentifier = "CardCell"
    }
    
    enum UI {
        
        static let MinimumSpacingForCellSection: CGFloat = 2.0
        static let LineSpacingMultiplier: CGFloat = 3.0
        
        static let ContentOffsetSearchBarHidden: CGFloat = -50.0
        static let ContentOffsetSearchBarVisible: CGFloat = 0.0
        
        static let CardCellWidth: CGFloat = 123.0
        static let CardCellHeight: CGFloat = 200.0
        
    }
    
}
