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




struct ContentView: View {
    
    @State var myCardData = [CardData]()
    @State var jsonUrl = "https://us-east.browsedns.net/data.json "
    
    init() {
        refreshUrl()
    }
    
    func refreshUrl() {
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode([CardData].self, from: makeCall(jsonUrl))
            myCardData = decoded
        } catch {
            print("Failed to decode JSON")
        }
    }
    
    
    var body: some View {
        VStack{
            HStack {
                Text("Hello, world!")
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
                    ForEach(myCardData, id: \.self) { card in
                        Card(data: card)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
