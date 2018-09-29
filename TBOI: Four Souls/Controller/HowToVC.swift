//
//  HowToVC.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/26/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit
import FSPagerView

class HowToVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = UserDefaults.Locale.PagerData.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
            
            self.pageControl.setStrokeColor(nil, for: .normal)
            self.pageControl.setStrokeColor(nil, for: .selected)
            self.pageControl.setFillColor(nil, for: .normal)
            self.pageControl.setFillColor(nil, for: .selected)
            self.pageControl.setImage(nil, for: .normal)
            self.pageControl.setImage(nil, for: .selected)
            self.pageControl.setPath(nil, for: .normal)
            self.pageControl.setPath(nil, for: .selected)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.delegate = self
        pagerView.dataSource = self
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- FSPagerViewDataSource
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return UserDefaults.Locale.PagerData.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let contentView = cell.contentView
        clearPagerViewCell(cell)
        
        let anchorConst = UserDefaults.UI.HowToVC.AnchorConstant
        let halfAnchorConst = UserDefaults.UI.HowToVC.AnchorConstant / 2
        
        let scrollView = createScrollView()
        contentView.addSubview(scrollView)
    
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: halfAnchorConst).isActive = true
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: halfAnchorConst).isActive = true
        scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -halfAnchorConst).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -halfAnchorConst).isActive = true
        
        let topLine = UIView()
        topLine.tag = UserDefaults.Tag.PagerViewDefaultTag
        topLine.backgroundColor = .gray
        topLine.frame = UserDefaults.UI.HowToVC.TopLineRect
        scrollView.addSubview(topLine)
        //topLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst).isActive = true
        
        // add labelOne to the scroll view
        let labelTitle = createTitleLabel()
        scrollView.addSubview(labelTitle)
        labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorConst).isActive = true
        labelTitle.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: anchorConst).isActive = true
        labelTitle.text = UserDefaults.Locale.PagerData[index][0]
        
        var bottomAnchor: NSLayoutYAxisAnchor = labelTitle.bottomAnchor
        var bottomAnchorConstant: CGFloat = anchorConst
        
        let imageName = UserDefaults.Locale.PagerImageData[index]
        if !imageName.isEmpty {
            
            let isLandscapeImage = imageName.contains("image1")

            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            imageView.frame.size.width = UserDefaults.UI.HowToVC.imageWidth(viewType: isLandscapeImage)
            imageView.frame.size.height = UserDefaults.UI.HowToVC.imageHeight(viewType: isLandscapeImage)
            imageView.frame.origin.y = UserDefaults.UI.HowToVC.Spacer
            imageView.tag = UserDefaults.Tag.PagerViewDefaultTag
            scrollView.addSubview(imageView)
            print(imageView.frame.size)
            bottomAnchor = imageView.bottomAnchor
            bottomAnchorConstant = 0
        }
        
        let labelDescription = createDescriptionLabel()
        scrollView.addSubview(labelDescription)
        labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorConst).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorConst).isActive = true
        labelDescription.topAnchor.constraint(equalTo: bottomAnchor, constant: bottomAnchorConstant).isActive = true
        labelDescription.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
        labelDescription.text = UserDefaults.Locale.PagerData[index][1]
        
        return cell
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
        
        //clearPagerViewCell(cell)
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
    
    func createScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = UserDefaults.Tag.PagerViewScrollViewTag
        return view
    }
    
    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UserDefaults.UI.HowToVC.TitleUIFont
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = UserDefaults.Tag.PagerViewDefaultTag
        return label
    }
    
    func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UserDefaults.UI.HowToVC.DescriptionUIFont
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = UserDefaults.Tag.PagerViewDefaultTag
        return label
    }
    
    

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }

}
