//
//  CardsBundleInfo.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/8/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import Foundation

class CardsBundleInfo {
    
    private var _title: String!
    private var _cards = Array<CardInfo>()
    
    private var titleID = "title"
    private var cardsID = "cards"
    
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    var cards: Array<CardInfo> {
        return _cards
    }
    
    var size: Int {
        return _cards.count
    }
    
    init(with dict: Dictionary<String, Any>) {
        parseInfo(from: dict)
    }
    
    func parseInfo(from dict: Dictionary<String, Any>) {
        if let title = dict[titleID] as? String {
            self._title = title
        }
        if let cardsArr = dict[cardsID] as? Array<Dictionary<String,String>> {
            for cardDict in cardsArr {
                let card = CardInfo(with: cardDict)
                self._cards.append(card)
            }
        }
    }
}

extension CardsBundleInfo: CustomStringConvertible {
    
    var description: String {
        return "(\(titleID): \(title), \(cardsID): \(cards))"
    }
}
