//
//  MainVC.swift
//  Isaac's Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/5/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit
import Hero
import SideMenuSwift

class MainVC: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var wikiLabel: UILabel!
    
    internal var cardsData = Array<CardsBundleInfo>()
    
    override func loadView() {
        super.loadView()
        
        loadDataFromPlist()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        let shadowColor = UIColor(red:0.075, green:0.05, blue:0.05, alpha:1.0)
        wikiLabel.enableShadow(color: shadowColor, radius: 3, opacity: 1)
    }
    
    func loadDataFromPlist() {
        
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "plist") else {return}
        let arr = NSArray(contentsOf: url) as! [Any]
        
        for obj in arr {
            guard let dict = obj as? Dictionary<String, Any> else {continue}
            let cardsBundle = CardsBundleInfo(with: dict)
            cardsData.append(cardsBundle)
//            print(cardsBundle)
        }
    }
    
    @IBAction func onInfoButtonPressed(_ sender: Any) {

        sideMenuController?.revealMenu()
        /*if let vc2 = storyboard?.instantiateViewController(withIdentifier: UserDefaults.ID.HowToVCSegueId) {
            // this enables Hero
            vc2.hero.isEnabled = true
            
            
            // this configures the built in animation
            //    vc2.hero.modalAnimationType = .zoom
            //    vc2.hero.modalAnimationType = .pageIn(direction: .left)
            //    vc2.hero.modalAnimationType = .pull(direction: .left)
            //    vc2.hero.modalAnimationType = .autoReverse(presenting: .pageIn(direction: .left))
            vc2.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
            
            DispatchQueue.main.async {
                self.present(vc2, animated: true, completion: nil)
            }
        }*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == UserDefaults.ID.DetailedVCSegueId {
            guard let detailedVC = segue.destination as? DetailedVC else {return}
            guard let bundle = sender as? CardsBundleInfo else {return}
            detailedVC.cardsBundle = bundle
        }
        else if segue.identifier == UserDefaults.ID.HowToVCSegueId {
            
            guard let aboutVC = segue.destination as? HowToVC else {return}
            guard let sender = sender as? UIButton else {return}
            sender.hero.id = "selected"
            aboutVC.view.hero.modifiers = [.source(heroID: "selected")]
        }
    }
}

extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let bundleInfo = cardsData[indexPath.row]
        performSegue(withIdentifier: UserDefaults.ID.DetailedVCSegueId, sender: bundleInfo)
        
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
        
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: UserDefaults.ID.MenuViewCellReuseId, for: indexPath) as? MenuCell {
            let bundleInfo = cardsData[indexPath.row]
            cell.configureCell(title: bundleInfo.title)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UserDefaults.UI.MenuItemCellWidth, height: UserDefaults.UI.MenuItemCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: UserDefaults.UI.MenuItemHeightForFooterInSection)
    }
}

