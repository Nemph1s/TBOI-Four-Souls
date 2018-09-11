//
//  DetailedVC.swift
//  Isaac's Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/7/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var constrainHeightHeader: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    @IBOutlet weak var bluredBgView: UIView!
    @IBOutlet weak var closeupCardView: CloseupCardView!
    
    var cardsBundle: CardsBundleInfo!
    var filteredCards = Array<CardInfo>()
    
    var contentOffset: CGFloat = 0.0
    
    var selectedCellId: Int = 0
    
    var cellOne: CardCell!
    
    var isSwipedDownFromBanner = false
    var inSearchMode = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        initCloseUpViews()
        updateUI()
    }
    
    func updateUI() {
        titleLabel.text = cardsBundle.title
        itemsCountLabel.text = "x\(cardsBundle.size)"
    }
    
    func updateUIViewConstraints() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        //        let translation = recognizer.translation(in: self.view)
        //        if let view = recognizer.view {
        //            view.center = CGPoint(x:view.center.x + translation.x,
        //                                  y:view.center.y + translation.y)
        //        }
        //        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        disableBlurForBG()
        disableCloseUpCardView()
    }
    
    
}

extension DetailedVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            self.collectionView.reloadData()
            view.endEditing(true)
        }
        else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredCards = cardsBundle.cards.filter({$0.name.lowercased().range(of: lower) != nil})
            self.collectionView.reloadData()
        }
    }
}

extension DetailedVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        updateImageForCloseUpView(by: indexPath)
        enableBlurForBG()
        enableCloseUpCardView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.contentOffset = self.collectionView.contentOffset.y
        isSwipedDownFromBanner = contentOffset <= 0.0 ? true : false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = self.collectionView.contentOffset.y
        if scrollPos == self.contentOffset {
            return
        }
        if scrollPos > self.contentOffset {
            //Fully hide your toolbar
            if constrainHeightHeader.constant != UserDefaults.UI.ContentOffsetSearchBarHidden {
                self.constrainHeightHeader.constant = UserDefaults.UI.ContentOffsetSearchBarHidden
                updateUIViewConstraints()
            }
        }
        else {
            if !self.isSwipedDownFromBanner {
                return
            }
            if self.constrainHeightHeader.constant != UserDefaults.UI.ContentOffsetSearchBarVisible {
                self.constrainHeightHeader.constant = UserDefaults.UI.ContentOffsetSearchBarVisible
                updateUIViewConstraints()
            }
        }
    }
}

extension DetailedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredCards.count
        }
        return cardsBundle.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDefaults.ID.CardCellReuseId, for: indexPath) as! CardCell
        
        let cardInfo: CardInfo!
        cardInfo = inSearchMode ? filteredCards[indexPath.row] : cardsBundle.cards[indexPath.row]
        cell.image = UIImage(named: cardInfo.pictureSmall)!
        cell.text = cardInfo.name
        
        return cell
    }
}

extension DetailedVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UserDefaults.UI.CardCellWidth, height: UserDefaults.UI.CardCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UserDefaults.UI.MinimumSpacingForCellSection * UserDefaults.UI.LineSpacingMultiplier
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UserDefaults.UI.MinimumSpacingForCellSection
    }
}

// Animation in CloseUp View
extension DetailedVC: UIGestureRecognizerDelegate {
    
    func initCloseUpViews() {
        
        bluredBgView.isHidden = true
        bluredBgView.alpha = 0.0
        let blurEffect = UIBlurEffect(style: .dark) // .extraLight or .dark
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        blurEffectView.tag = UserDefaults.Tags.BlurEffectView.rawValue
        bluredBgView.addSubview(blurEffectView)
        
        closeupCardView.isHidden = true
        closeupCardView.alpha = 0.0
        
        
        tapGestureRecognizer.delegate = self
        swipeGestureRecognizer.delegate = self
    }
    
    func updateImageForCloseUpView(by indexPath: IndexPath) {
        
        let cardInfo: CardInfo!
        cardInfo = inSearchMode ? filteredCards[indexPath.row] : cardsBundle.cards[indexPath.row]
        closeupCardView.cardImage.image = UIImage(named: cardInfo.picture)!
    }
    
    func enableBlurForBG() {
        
        self.bluredBgView.isHidden = false
        UIView.animate(withDuration: 0.25, delay: 0.2, options: .curveEaseOut, animations: {
            self.bluredBgView.alpha = 1.0
        }, completion: { finished in
        })
    }
    
    func enableCloseUpCardView() {

        self.closeupCardView.isHidden = false
        UIView.animate(withDuration: 0.25, delay: 0.2, options: .curveEaseOut, animations: {
            self.closeupCardView.alpha = 1.0
        }, completion: { finished in
        })
    }
    
    func disableBlurForBG() {
        
        
        UIView.animate(withDuration: 0.25, delay: 0.2, options: .curveEaseOut, animations: {
            self.bluredBgView.alpha = 0.0
        }, completion: { finished in
            self.bluredBgView.isHidden = true
        })
    }
    
    func disableCloseUpCardView() {
        
        UIView.animate(withDuration: 0.25, delay: 0.2, options: .curveEaseOut, animations: {
            self.closeupCardView.alpha = 0.0
        }, completion: { finished in
            self.closeupCardView.isHidden = true
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    

}
