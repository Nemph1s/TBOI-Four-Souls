//
//  HowToVC.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/26/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit
import FSPagerView


class HowToVC: UIViewController {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: UserDefaults.ID.HowToCellReuseId)
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = UserDefaults.Locale.PagerData.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    
    var pagerViewCell: FSPagerViewCell? = nil
    var scrollView: UIScrollView? = nil
    var topLineView: UIView? = nil
    var titleLabel: UILabel? = nil
    var descriptionImage: UIImageView? = nil
    var descriptionLabel: UILabel? = nil
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension HowToVC: FSPagerViewDelegate {
    
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
        
        let imageName = UserDefaults.Locale.PagerImageData[index]
        if imageName.isEmpty {
            scrollViewHeight += UserDefaults.UI.HowToVC.Spacer
        }
        
        for subview in scrollView.subviews {
            if subview is UIImageView {
                scrollViewHeight += subview.frame.size.height
            }
            else {
                scrollViewHeight += subview.intrinsicContentSize.height
            }
        }
        scrollView.contentSize = CGSize(width: 0, height: scrollViewHeight)
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
        titleLabel = nil
        descriptionImage = nil
        descriptionLabel = nil
    }
}

extension HowToVC: FSPagerViewDataSource {
    
    /// Asks your data source object for the number of items in the pager view.
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return UserDefaults.Locale.PagerData.count
    }
    
    /// Asks your data source object for the cell that corresponds to the specified item in the pager view.
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        clearPagerViewOptionals()
        pagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: UserDefaults.ID.HowToCellReuseId, at: index)
        
        scrollView = UIHelper.createScrollView()
        pagerViewCell!.contentView.addSubview(scrollView!)
        
        topLineView = UIHelper.createTopLine()
        scrollView!.addSubview(topLineView!)
        
        // add labelOne to the scroll view
        titleLabel = UIHelper.createTitleLabel()
        scrollView!.addSubview(titleLabel!)
 
        let imageName = UserDefaults.Locale.PagerImageData[index]
        if !imageName.isEmpty {
            
            let isLandscapeImage = imageName.contains(UserDefaults.UI.LandscapeImageName)
            descriptionImage = UIHelper.createDescriptionImage(named: imageName, orientation: isLandscapeImage)
            scrollView!.addSubview(descriptionImage!)
        }
        
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
        scroll.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: halfAnchorConst).isActive = true
        scroll.topAnchor.constraint(equalTo: contentView.topAnchor, constant: halfAnchorConst).isActive = true
        scroll.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -halfAnchorConst).isActive = true
        scroll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -halfAnchorConst).isActive = true
        
        guard let title = titleLabel else {return}
        guard let topLine = topLineView else {return}
        
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorConst).isActive = true
        title.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: anchorConst).isActive = true
        title.text = UserDefaults.Locale.PagerData[index][0]
        
        let isEmptyImg = UserDefaults.Locale.PagerImageData[index].isEmpty
        let bottomAnchor = isEmptyImg ? title.bottomAnchor : descriptionImage!.bottomAnchor
        let constant: CGFloat = isEmptyImg ? anchorConst : 0
        
        guard let description = descriptionLabel else {return}
        
        description.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst).isActive = true
        description.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorConst).isActive = true
        description.topAnchor.constraint(equalTo: bottomAnchor, constant: constant).isActive = true
        description.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
        description.text = UserDefaults.Locale.PagerData[index][1]
    }
}
