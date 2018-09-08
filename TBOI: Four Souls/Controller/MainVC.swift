//
//  MainVC.swift
//  Isaac's Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/5/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    
    let reuseIdentifier = "menuViewCell"
    let segueDetailedIdentifier = "CardDetailedVC"
    
    internal var cardsData = Array<CardsBundleInfo>()
    
    override func loadView() {
        super.loadView()
        
        if let url = Bundle.main.url(forResource: "cards", withExtension: "plist") {
            let arr = NSArray(contentsOf: url) as! [Any]
            for obj in arr {
                if let dict = obj as? Dictionary<String, Any> {
                    let cardsBundle = CardsBundleInfo(with: dict)
                    cardsData.append(cardsBundle)
                    print(cardsBundle)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetailedIdentifier {
            if let detailedVC = segue.destination as? DetailedVC, let bundle = sender as? CardsBundleInfo {
                detailedVC.cardsBundle = bundle
            }
        }
    }
}

extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let bundleInfo = cardsData[indexPath.row]
        performSegue(withIdentifier: segueDetailedIdentifier, sender: bundleInfo)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MenuCell {
            let bundleInfo = cardsData[indexPath.row]
            cell.configureCell(title: bundleInfo.title)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 272, height: 120)
    }
}

