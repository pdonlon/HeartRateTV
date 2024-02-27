//
//  Card.swift
//  HeartRate
//
//  Created by Philip Donlon on 2/21/24.
//

import Foundation
import SwiftUI

struct Card: View {
    
    var data: CardData
    
    var body: some View {
        Button(action: {
            print(data.title)
        }) {
            VStack {
                AsyncImage(
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
                Text(data.title)
            }
//            .background(Color.blue)
            .frame(width: 200, height: 200)
        }
    }
    
}
