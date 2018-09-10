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
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let reuseIdentifier = "CardCell"
    
    let minimumSpacingForCellSection: CGFloat = 2.0
    var contentOffset: CGFloat = 0.0
    
    var isSwipedDownFromBanner = false
    let contentOffsetSearchBarHidden: CGFloat = -50.0
    let contentOffsetSearchBarVisible: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        updateUI()
    }
    
    func updateUI() {
        
        titleLabel.text = cardsBundle.title
        itemsCountLabel.text = "x\(cardsBundle.cards.count)"
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
            if constrainHeightHeader.constant != contentOffsetSearchBarHidden {
                self.constrainHeightHeader.constant = contentOffsetSearchBarHidden
                updateUIViewConstraints()
            }
        }
        else {
            if !self.isSwipedDownFromBanner {
                return
            }
            if self.constrainHeightHeader.constant != contentOffsetSearchBarVisible {
                self.constrainHeightHeader.constant = contentOffsetSearchBarVisible
                updateUIViewConstraints()
            }
        }
    }
}

extension DetailedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsBundle.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        let cardInfo = cardsBundle.cards[indexPath.row]
        cell.image = UIImage(named: cardInfo.picture)!
        cell.text = cardInfo.name
        
        
        return cell
    }
}

extension DetailedVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 123, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacingForCellSection * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacingForCellSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
     
     }*/
}
