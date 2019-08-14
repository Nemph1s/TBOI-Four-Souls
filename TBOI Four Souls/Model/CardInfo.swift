//
//  CardInfo.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/8/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import Foundation

class CardInfo {
    private var _name: String!
    private var _picture: String!
    
    private var nameID = "name"
    private var pictureID = "picture"
    
    var name: String {
        return _name
    }
    
    var picture: String {
        return _picture
    }
    
    var pictureSmall: String {
        return "\(picture)Small"
    }
    
    
    init(with dict: Dictionary<String, String>) {
        parseInfo(from: dict)
    }
    
    func parseInfo(from dict: Dictionary<String, String>) {
        self._name = dict[nameID] ?? ""
        self._picture = dict[pictureID] ?? ""
    }
}

extension CardInfo: CustomStringConvertible {
    
    var description: String {
        return "(\(nameID): \(name), \(pictureID): \(picture))"
    }
}
