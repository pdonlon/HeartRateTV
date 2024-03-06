//
//  ContentView.swift
//  HeartRate
//
//  Created by Philip Donlon on 2/19/24.
//

import SwiftUI

//let allCardData = [
//    CardData(title: "Philip", thumbnail: "https://avatars.githubusercontent.com/u/2906828?s=100"),
//    CardData(title: "Ricky", thumbnail: "https://rickyayoub.com/pages/about.page/png/me.jpg"),
//    CardData(title: "Jason", thumbnail: "https://images.squarespace-cdn.com/content/v1/5a301164268b96adc28fe647/1586009407723-5IS0U9N7UIR6HVCCWO9B/LCB_17.jpg?format=2500w")
//    
//]


import Combine

struct ContentView: View {
    
    @State var myCardData = [CardData]()
    @State var jsonUrl = "https://us-east.browsedns.net/data.json "
    
    @State var showingSheet = false
    @State var selectedCard: CardData?
    
    var timerPublisher: Timer.TimerPublisher
    var timerSubscriber: AnyCancellable
    
    init() {
        // get a publisher from the system timer for every half second
        timerPublisher = Timer.publish(every: 0.5, on: .main, in: .common)
        
        // hook up our subscriber to print on published time events
        timerSubscriber = timerPublisher
            .autoconnect()
            .map({
                // do network stuff, to pull latest data
                let formatter = DateFormatter()
                  formatter.dateFormat = "HH:mm:ss"
                  
                  return formatter.string(from: $0)
            })
            .sink(receiveValue: {
                // actually update our UI or data
                print("Current Time: \($0)")
            })
        
        //  timerSubscriber.cancel()
            
        refreshUrl()
    }
    
    func refreshUrl() {
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode([CardData].self, from: makeCall(jsonUrl))
            myCardData = decoded
        } catch {
            print("Error info: \(error)")
        }
    }
    
    
    var body: some View {
        VStack{
            HStack {
                if let _ = selectedCard {
                    // make sure swiftui knows to redraw selectedcard
                    // https://forums.developer.apple.com/forums/thread/652080
                }
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            HStack {
                if (myCardData.isEmpty) {
                    Button {
                        jsonUrl = "https://us-east.browsedns.net/data.json"
                        refreshUrl()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    }

                    Text("Nothing found")
                }
                else {
                    ForEach(myCardData, id: \.self) { data in
                        Card(data: data, onSelect: {
                            selectedCard = data
                            showingSheet = true
                        })
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingSheet, content: {
            if let card = selectedCard {
                Text(card.title)
            } else {
                Text("Issue Occured")
            }
        })
    }
}

#Preview {
    ContentView()
}
