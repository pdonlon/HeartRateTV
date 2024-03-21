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
    //    @State var jsonUrl = "http://switch-gba.browsedns.net/"
    @State var jsonUrl = "http://192.168.0.14:8080"
    
    @State var showingSheet = false
    @State var selectedCard: CardData?
    @StateObject var viewModel = ObservableCardModel()
    
    init() {
                
    }
    
    func refreshUrl() {
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode([CardData].self, from: makeCall(jsonUrl))
//            myCardData = decoded
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
                Button {
//                    jsonUrl = "http://switch-gba.browsedns.net/"
                    jsonUrl = "http://192.168.0.14:8080"
                    refreshUrl()
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
                if (viewModel.myCardData.isEmpty) {

                    Text("Nothing found")
                }
                else {
                    ForEach(viewModel.myCardData, id: \.self) { data in
                        Card(data: data, onSelect: {
                            selectedCard = data
                            showingSheet = true
                        })
                    }
                }
            }
            .padding()
        }
        .onAppear() {
            viewModel.fetchData(every: 0.1)
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
