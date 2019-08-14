//
//  LicenseVC.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 10/10/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit
/*
class LicenseVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        scrollView = UIHelper.createScrollView()
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        let anchorConst = UserDefaults.UI.HowToVC.AnchorConstant
        let halfAnchorConst = UserDefaults.UI.HowToVC.AnchorConstant / 2
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: halfAnchorConst).isActive = true
        scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: anchorConst).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -halfAnchorConst).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -anchorConst).isActive = true
        
        let descriptionLabel = UIHelper.createDescriptionLabel()
        scrollView.addSubview(descriptionLabel)
        
        descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: anchorConst).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -anchorConst).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: anchorConst).isActive = true
        descriptionLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
        descriptionLabel.text = UserDefaults.Locale.LicenseData[0]
        
        var bottomAnchor: NSLayoutYAxisAnchor = descriptionLabel.bottomAnchor
        
        for _ in 1...5 {
            let lbl = UIHelper.createDescriptionLabel()
            scrollView.addSubview(lbl)
            
            lbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: anchorConst).isActive = true
            lbl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -anchorConst).isActive = true
            lbl.topAnchor.constraint(equalTo: bottomAnchor, constant: anchorConst).isActive = true
            lbl.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
            lbl.text = UserDefaults.Locale.LicenseData[1]
            
            bottomAnchor = lbl.bottomAnchor
        }
        
        print(scrollView.frame.size)
        print(scrollView.contentSize)
        
    /*
        var scrollViewHeight: CGFloat = 0.0;
        for subview in scrollView.subviews {
            scrollViewHeight += subview.intrinsicContentSize.height
            print(scrollViewHeight)
        }
        scrollView.contentSize = CGSize(width: 0, height: scrollViewHeight)*/
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var scrollViewHeight: CGFloat = 0.0;
        for subview in scrollView.subviews {
            scrollViewHeight += subview.intrinsicContentSize.height
            print(scrollViewHeight)
        }
        scrollView.contentSize = CGSize(width: 0, height: scrollViewHeight)
        print(scrollView.frame.size)
        print(scrollView.contentSize)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
*/




import FSPagerView


class LicenseVC: UIViewController {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: UserDefaults.ID.HowToCellReuseId)
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = 0
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    
    var pagerViewCell: FSPagerViewCell? = nil
    var scrollView: UIScrollView? = nil
    var topLineView: UIView? = nil
    var descriptionLabel: UILabel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0 {
            scrollView.contentOffset.x = 0
        }
    }
}

extension LicenseVC: FSPagerViewDelegate {
    
    /// Tells the delegate when the user finishes scrolling the content.
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    /// Tells the delegate that the item at the specified index was selected.
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    /// Tells the delegate that the specified cell is about to be displayed in the pager view.
    public func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        
        var scrollViewHeight: CGFloat = 0.0;
        let scrollViewTag = UserDefaults.Tag.PagerViewScrollViewTag
        let scrollView = cell.contentView.viewWithTag(scrollViewTag) as! UIScrollView
        
        for subview in scrollView.subviews {
            scrollViewHeight += subview.intrinsicContentSize.height
        }
        scrollView.contentSize = CGSize(width: 0, height: scrollViewHeight)
        
        print(scrollView.contentSize)
    }
    
    /// Tells the delegate that the specified cell was removed from the pager view.
    public func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
        
        clearPagerViewCell(cell)
    }
    
    func isPageViewItem(_ subview: UIView) -> Bool {
        return subview.tag == UserDefaults.Tag.PagerViewDefaultTag || subview.tag == UserDefaults.Tag.PagerViewScrollViewTag
    }
    
    func clearPagerViewCell(_ cell: FSPagerViewCell) {
        let contentView = cell.contentView
        for subview in contentView.subviews {
            if isPageViewItem(subview) {
                subview.removeFromSuperview()
            }
        }
    }
    
    func clearPagerViewOptionals() {
        
        pagerViewCell = nil
        scrollView = nil
        topLineView = nil
        descriptionLabel = nil
    }
}

extension LicenseVC: FSPagerViewDataSource {
    
    /// Asks your data source object for the number of items in the pager view.
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 1
    }
    
    /// Asks your data source object for the cell that corresponds to the specified item in the pager view.
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        clearPagerViewOptionals()
        pagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: UserDefaults.ID.HowToCellReuseId, at: index)
        
        scrollView = UIHelper.createScrollView()
        pagerViewCell!.contentView.addSubview(scrollView!)
        
        topLineView = UIHelper.createTopLine()
        scrollView!.addSubview(topLineView!)
        
        descriptionLabel = UIHelper.createDescriptionLabel()
        scrollView!.addSubview(descriptionLabel!)
        
        updatePagerCell(at: index)
        
        return pagerViewCell!
    }
    
    
    func updatePagerCell(at index: Int) {
        
        guard let contentView = pagerViewCell?.contentView else {return}
        guard let scroll = scrollView else {return}
        
        let anchorConst = UserDefaults.UI.HowToVC.AnchorConstant
        let halfAnchorConst = UserDefaults.UI.HowToVC.AnchorConstant / 2
        
        // constrain the scroll view to 8-pts on each side
        scroll.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: anchorConst).isActive = true
        scroll.topAnchor.constraint(equalTo: contentView.topAnchor, constant: halfAnchorConst).isActive = true
        scroll.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -anchorConst).isActive = true
        scroll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -halfAnchorConst).isActive = true
        
        guard let topLine = topLineView else {return}
        guard let description = descriptionLabel else {return}
        
        description.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst).isActive = true
        description.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorConst).isActive = true
        description.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: anchorConst).isActive = true
        description.widthAnchor.constraint(lessThanOrEqualToConstant: 350).isActive = true
        description.text = UserDefaults.Locale.LicenseData[0]
        
        var bottomAnchor: NSLayoutYAxisAnchor = description.bottomAnchor
        
        for index in 1..<UserDefaults.Locale.LicenseData.count {
            
            let lbl = UIHelper.createDescriptionLabel()
            scrollView!.addSubview(lbl)
            
            lbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst).isActive = true
            lbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorConst).isActive = true
            lbl.topAnchor.constraint(equalTo: bottomAnchor, constant: anchorConst).isActive = true
            lbl.widthAnchor.constraint(lessThanOrEqualToConstant: 350).isActive = true
            lbl.text = UserDefaults.Locale.LicenseData[index]
            
            bottomAnchor = lbl.bottomAnchor
        }
    }
}
