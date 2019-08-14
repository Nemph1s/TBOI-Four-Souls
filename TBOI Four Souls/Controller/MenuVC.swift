//
//  MenuVC.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 10/6/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit
import SideMenuSwift

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

class MenuVC: UIViewController {

    var isDarkModeEnabled = false
    
    @IBOutlet weak var selectionTableViewHeader: UILabel!
    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var blurredBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()

        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: UserDefaults.ID.HowToVCSegueId)
        }, with: UserDefaults.SideMenuId.HowToVC)

        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: UserDefaults.ID.LicenseVCSegueId)
        }, with: UserDefaults.SideMenuId.LicenseVC)
        
        sideMenuController?.delegate = self
    }
    
    private func configureView() {
        
        SideMenuController.preferences.basic.direction = .right
        
        selectionTableViewHeader.textColor = .white
        selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        blurEffectView.tag = UserDefaults.Tag.BlurEffectView
        blurredBgView.addSubview(blurEffectView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - size.width
        view.layoutIfNeeded()
    }
}

extension MenuVC: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController, animationControllerFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.Locale.MenuItemNames.count
    }
    
    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuCell
        cell.titleLabel?.text = UserDefaults.Locale.MenuItemNames[indexPath.row]
        cell.titleLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        sideMenuController?.setContentViewController(with: "\(row)", animated: Preferences.shared.enableTransitionAnimation)
        sideMenuController?.hideMenu()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserDefaults.UI.SideMenuHeightForRowAt
    }
}

class SideMenuCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}
