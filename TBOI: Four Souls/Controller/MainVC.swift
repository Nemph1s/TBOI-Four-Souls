//
//  MainVC.swift
//  Isaac's Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/5/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit
import Hero
import SideMenu

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
        
        setupSideMenu()
        setDefaults()
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        /*SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController*/
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: self)
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        
        // Set up a cool background image for demo purposes
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "stars")!)
    }
    
    fileprivate func setDefaults() {
        //let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
        SideMenuManager.default.menuPresentMode = .menuDissolveIn
        
        //let styles:[UIBlurEffect.Style] = [.dark, .light, .extraLight]
        SideMenuManager.default.menuBlurEffectStyle = .dark
        /*
        darknessSlider.value = Float(SideMenuManager.default.menuAnimationFadeStrength)
        shadowOpacitySlider.value = Float(SideMenuManager.default.menuShadowOpacity)
        shrinkFactorSlider.value = Float(SideMenuManager.default.menuAnimationTransformScaleFactor)
        screenWidthSlider.value = Float(SideMenuManager.default.menuWidth / view.frame.width)
        blackOutStatusBar.isOn = SideMenuManager.default.menuFadeStatusBar
 */
    }
    
    func loadDataFromPlist() {
        
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "plist") else {return}
        let arr = NSArray(contentsOf: url) as! [Any]
        
        for obj in arr {
            guard let dict = obj as? Dictionary<String, Any> else {continue}
            let cardsBundle = CardsBundleInfo(with: dict)
            cardsData.append(cardsBundle)
        }
    }
    
    @IBAction func onInfoButtonPressed(_ sender: Any) {

        //present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        if let vc = storyboard?.instantiateViewController(withIdentifier: UserDefaults.ID.MenuNavigationSegueId) {
            // this enables Hero
            //vc2.hero.isEnabled = true
            
            
            // this configures the built in animation
            //    vc2.hero.modalAnimationType = .zoom
            //    vc2.hero.modalAnimationType = .pageIn(direction: .left)
            //    vc2.hero.modalAnimationType = .pull(direction: .left)
            //    vc2.hero.modalAnimationType = .autoReverse(presenting: .pageIn(direction: .left))
            //vc2.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
            
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        }
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

