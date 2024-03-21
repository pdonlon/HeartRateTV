//
//  CardData.swift
//  HeartRate
//
//  Created by Philip Donlon on 2/21/24.
//

import Foundation

class CardData : Hashable, Codable, Identifiable{
    
    // Heart data TODO
    var title: String
    var thumbnail: String
    var bpm: Int
    var age: Int
    
    static func == (lhs: CardData, rhs: CardData) -> Bool {
        return (lhs.title == rhs.title) && (lhs.thumbnail == rhs.thumbnail) && (lhs.bpm == rhs.bpm) && lhs.age == rhs.age
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(thumbnail)
        hasher.combine(bpm)
        hasher.combine(age)
    }
    
    
    func getPercentMaxHeartRate() -> Double {
        let maxHeartRate = 220 - age
        
        print(title, bpm, age)
        
        return Double(bpm)/Double(maxHeartRate)
    }
}
