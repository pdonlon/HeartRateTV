//
//  Card.swift
//  HeartRate
//
//  Created by Philip Donlon on 2/21/24.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct Card: View {
    
    var data: CardData
    var onSelect: () -> Void
    
    init(data: CardData, onSelect: @escaping () -> Void) {
        self.data = data
        self.onSelect = onSelect
    }
    
    var body: some View {
        Button(action: {
            onSelect()
            print(data.title)
        }) {
            VStack {
                CachedAsyncImage(
                    url: URL(string: data.thumbnail),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 100)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                HStack {
                    Text(data.title)
                    VStack {
                        CircularProgressView(progress: data.getPercentMaxHeartRate())
                        Text("\(data.bpm)")
                    }
                    
                }
            }
//            .background(Color.blue)
            .frame(width: 250, height: 200)
        }
    }
    
}
