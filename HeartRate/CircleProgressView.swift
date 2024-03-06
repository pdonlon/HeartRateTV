//
//  CircleProgressView.swift
//  HeartRate
//
//  Created by Philip Donlon on 3/5/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let diameter: CGFloat = 50.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    colorPick(progress).opacity(0.5),
                    lineWidth: 15
                )
                .frame(width: diameter, height:diameter)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    colorPick(progress),
                    style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round
                    )
                )
                .frame(width: diameter, height:diameter)
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeOut, value: progress)

        }
    }
    
    func colorPick(_ percent: Double) -> Color {
        //zone 5
        if percent >= 0.90 {
            return Color.red
        }
        //zone 4
        else if percent >= 0.80 {
            return Color.orange
        }
        //zone 3
        else if percent >= 0.70{
            return Color.yellow
        }
        //zone 2
        else if percent >= 0.60{
            return Color.green
        }
        //zone 1
        else if percent >= 0.50{
            return Color.purple
        }
        
        return Color.blue
    }
}
