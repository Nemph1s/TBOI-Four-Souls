//
//  UIHelper.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/29/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func createScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = UserDefaults.Tag.PagerViewScrollViewTag
        return view
    }
    
    static func createTopLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.tag = UserDefaults.Tag.PagerViewDefaultTag
        view.frame = UserDefaults.UI.HowToVC.TopLineRect
        return view
    }
    
    static func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.tag = UserDefaults.Tag.PagerViewDefaultTag
        label.font = UserDefaults.UI.HowToVC.TitleUIFont
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    static func createDescriptionImage(named imageName: String, orientation isLandscape: Bool) -> UIImageView {
        let view = UIImageView(image: UIImage(named: imageName))
        view.contentMode = UIView.ContentMode.scaleAspectFit
        view.frame.size = UserDefaults.UI.HowToVC.imageSize(viewType: isLandscape)
        view.frame.origin.y = UserDefaults.UI.HowToVC.Spacer
        view.tag = UserDefaults.Tag.PagerViewDefaultTag
        return view
    }
    
    static func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.tag = UserDefaults.Tag.PagerViewDefaultTag
        label.font = UserDefaults.UI.HowToVC.DescriptionUIFont
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

// Label Shadow
extension UILabel {
    func enableShadow(color: UIColor , radius: CGFloat, opacity: Float){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
