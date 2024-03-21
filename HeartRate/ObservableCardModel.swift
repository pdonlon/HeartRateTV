//
//  ObservableCardModel.swift
//  HeartRate
//
//  Created by Philip Donlon on 3/6/24.
//

import Foundation
import Combine

class ObservableCardModel: ObservableObject {
    
    @Published var myCardData = [CardData]()
    
    //var timerPublisher: Timer.TimerPublisher
    var timerSubscriber: AnyCancellable?
    
    func fetchData(every interval: TimeInterval) {
        guard let url = URL(string: "http://192.168.0.14:8080") else { return }
        
        timerSubscriber = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .flatMap { _ in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: [CardData].self, decoder: JSONDecoder())
                    .catch { _ in Just(self.myCardData) }
            }
            .assign(to: \.myCardData, on: self)
    
    }
}
