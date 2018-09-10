//
//  DetailedVC.swift
//  Isaac's Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/7/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {

    var cardsBundle: CardsBundleInfo!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemsCountLabel: UILabel!
    
    @IBOutlet weak var constrainHeightHeader: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredCards = Array<CardInfo>()
    
    var contentOffset: CGFloat = 0.0
    
    var isSwipedDownFromBanner = false
    var inSearchMode = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDefaults.ID.CardCellReuseIdentifier, for: indexPath) as! CardCell
        
        let cardInfo: CardInfo!
        cardInfo = inSearchMode ? filteredCards[indexPath.row] : cardsBundle.cards[indexPath.row]
        cell.image = UIImage(named: cardInfo.picture)!
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
