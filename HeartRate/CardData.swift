//
//  CardData.swift
//  HeartRate
//
//  Created by Philip Donlon on 2/21/24.
//

import Foundation

class CardData : Hashable, Codable {
    
    var title: String
    var thumbnail: String
    
    static func == (lhs: CardData, rhs: CardData) -> Bool {
        return (lhs.title == rhs.title) && (lhs.thumbnail == rhs.thumbnail)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(thumbnail)
    }
    
    init(title: String, thumbnail: String) {
        self.title = title
        self.thumbnail = thumbnail
    }
    
}
