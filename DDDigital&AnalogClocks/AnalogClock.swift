//
//  AnalogClock.swift
//  DDDigital&AnalogClocks
//
//  Created by joe on 5/10/25.
//

import SwiftUI

struct AnalogClock: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let date = timeline.date
            ClockView(date: date)
        }
    }
}

struct ClockView: View {
    let date: Date
    let circleRadius = 3.0
    
    var body: some View {
        Canvas {
            context,
            size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            
            let calendar = Calendar.current
            
            let seconds = calendar.component(.second, from: date)
            let minutes = calendar.component(.minute, from: date)
            let hours = calendar.component(.hour, from: date) % 12
            
            // angles for clock hands
            
            // center dot
            let centerCircle = Path(
                ellipseIn: CGRect(
                    x: center.x - circleRadius,
                    y: center.y - circleRadius,
                    width: 2 * circleRadius,
                    height: 2 * circleRadius
                )
            )
            
            context.fill(centerCircle, with: .color(.black))
        }
    }
}

#Preview {
    AnalogClock()
}
