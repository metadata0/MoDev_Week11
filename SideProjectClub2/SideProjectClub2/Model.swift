//
//  Model.swift
//  SideProjectClub2
//
//  Created by Henry Chen on 4/10/23.
//

import SwiftUI

struct Model: Encodable, Decodable {
    var items: [ItemModel]
    var uniqueId = 0
    
    init () {
        items = []
        self.reset();
    }
    
    mutating func reset () {
        uniqueId = 0
        items = []
    }
    
    mutating func addItem(_ item: ItemModel) {
        var nitem = item;
        uniqueId += 1
        nitem.id = uniqueId
        items.append(nitem)
    }
}

struct ItemModel: Identifiable, Hashable, Encodable, Decodable {
    var x: Int = 100
    var y: Int = 100
    var w: Int = 50
    var h: Int = 50
    var selected: Bool = false
    
    var id: Int = 0
    
    
    func colorNum_(color: Color) -> Int {
        
    }
}
