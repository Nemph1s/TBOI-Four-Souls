//
//  CloseupCardView.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/11/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit

class CloseupCardView: UIView {

    @IBOutlet weak var cardImage: UIImageView!
    
    private var _originPos: CGPoint!
    
    var originPos = CGPoint() {
        didSet {
            _originPos = originPos
        }
    }
    
    var image: UIImage = UIImage() {
        didSet {
            cardImage.image = image
        }
    }
    
    func saveOriginPos() {
        _originPos = CGPoint(x: cardImage.frame.origin.x, y: cardImage.frame.origin.y)
    }
    
    func resetImagePosToOrigin() {
        let pos = CGPoint(x: _originPos.x, y: _originPos.y)
        cardImage.frame = CGRect(x: pos.x, y: pos.y, width: cardImage.frame.size.width, height: cardImage.frame.size.height)
    }
    
    func changePosBy(delta: CGPoint) {
        let pos = CGPoint(x: cardImage.frame.origin.x + delta.x, y: cardImage.frame.origin.y + delta.y)
        cardImage.frame = CGRect(x: pos.x, y: pos.y, width: cardImage.frame.size.width, height: cardImage.frame.size.height)
    }
    
}
