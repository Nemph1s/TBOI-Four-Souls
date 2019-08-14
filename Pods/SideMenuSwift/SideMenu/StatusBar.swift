//
//  StatusBar.swift
//  SideMenu
//
//  Created by kukushi on 22/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit

extension UIWindow {

    // swiftlint:disable identifier_name
    /// Returns current application's `statusBarWindows`

    /// Changes the windows' visibility with custom behavior
    ///
    /// - Parameters:
    ///   - hidden: the windows hidden status
    ///   - behavior: status bar behavior
    internal func setStatusBarHidden(_ hidden: Bool, with behavior: SideMenuController.Preferences.StatusBarBehavior) {
        guard behavior != .none else {
            return
        }

        switch behavior {
        case .fade, .hideOnMenu:
            alpha = hidden ? 0 : 1
        case .slide:
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            transform = hidden ? CGAffineTransform(translationX: 0, y: -statusBarHeight) : .identity
        default:
            return
        }
    }

    internal func isStatusBarHidden(with behavior: SideMenuController.Preferences.StatusBarBehavior) -> Bool {
        switch behavior {
        case .none:
            return false
        case .fade, .hideOnMenu:
            return alpha == 0
        case .slide:
            return transform != .identity
        }
    }
}
