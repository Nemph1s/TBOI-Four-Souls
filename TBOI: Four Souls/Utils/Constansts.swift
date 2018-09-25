//
//  Constansts.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/10/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

extension UserDefaults {
    
    enum Tags: Int {
        case BlurEffectView = 1
    }
    
    enum ID {
        
        static let CardCellReuseId = "CardCell"
        static let MenuViewCellReuseId = "MenuViewCell"
        static let DetailedVCSegueId = "DetailedVC"
        static let AboutVCSegueId = "AboutVC"
    }
    
    enum UI {
        
        static let MenuItemCellWidth: CGFloat = 272.0
        static let MenuItemCellHeight: CGFloat = 110.0
        
        static let MenuItemHeightForFooterInSection: CGFloat = 40.0
        
        static let MinimumSpacingForCellSection: CGFloat = 2.0
        static let LineSpacingMultiplier: CGFloat = 3.0
        
        static let ContentOffsetSearchBarHidden: CGFloat = -50.0
        static let ContentOffsetSearchBarVisible: CGFloat = 0.0
        
        static let CardCellWidth: CGFloat = 123.0
        static let CardCellHeight: CGFloat = 191.0
        
        static let CardCellNormalWidth: CGFloat = 367.0
        static let CardCellNormalHeight: CGFloat = 500.0
        
    }
}

typealias UISwipeDirection = UISwipeGestureRecognizer.Direction

typealias AnimationCompete = () -> ()

public extension UIDevice {
    
    static var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case Unknown
    }
    static var screenType: ScreenType {
        guard iPhone else { return .Unknown}
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208, 1920:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        default:
            return .Unknown
        }
    }
    
}
