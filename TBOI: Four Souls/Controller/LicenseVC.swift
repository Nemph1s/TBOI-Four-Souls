//
//  LicenseVC.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 10/10/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class LicenseVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let descriptionLabel = UIHelper.createDescriptionLabel()
        scrollView.addSubview(descriptionLabel)
        
        let anchorConst = UserDefaults.UI.HowToVC.AnchorConstant
        descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: anchorConst).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -anchorConst).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: anchorConst).isActive = true
        descriptionLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
        descriptionLabel.text = UserDefaults.Locale.LicenseData[0]
        
        let alamofire = UIHelper.createDescriptionLabel()
        scrollView.addSubview(alamofire)
        
        alamofire.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: anchorConst).isActive = true
        alamofire.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -anchorConst).isActive = true
        alamofire.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: anchorConst).isActive = true
        alamofire.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
        alamofire.text = UserDefaults.Locale.LicenseData[1]
        
        var scrollViewHeight: CGFloat = 0.0;
        for subview in scrollView.subviews {
            scrollViewHeight += subview.intrinsicContentSize.height
            print(scrollViewHeight)
        }
        scrollView.contentSize = CGSize(width: 0, height: scrollViewHeight)
    }

}
