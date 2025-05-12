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
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            
            let calendar = Calendar.current
            
            let seconds = calendar.component(.second, from: date)
            let minutes = calendar.component(.minute, from: date)
            let hours = calendar.component(.hour, from: date) % 12
            
            // angles for clock hands
            func angle(for value: Int, unit: Int) -> Angle {
                .degrees(Double(value) / Double(unit) * 360 - 90)
            }
            
            // clock hands
            let secondAngle = angle(for: seconds, unit: 60)
            let minuteAngle = angle(for: minutes, unit: 60)
            let hourAngle = angle(for: hours * 5 + minutes / 12, unit: 60)
            
            func hand(at angle: Angle, length: CGFloat, color: Color) {
                let angleRadians: Double = angle.radians
                var path = Path()
                let end = CGPoint(
                    x: center.x + cos(Double(angleRadians)) * length,
                    y: center.y + sin(angleRadians) * length
                )
                path.move(to: center)
                path.addLine(to: end)
                context.stroke(path, with: .color(color), lineWidth: 2)
            }
            
            hand(at: hourAngle, length: size.width * 0.25, color: .primary)
            hand(at: minuteAngle, length: size.width * 0.35, color: .primary)
            hand(at: secondAngle, length: size.width * 0.4, color: .red)
            
            // draw clock numbers 1-12
            let radius = min(size.width, size.height) / 2
            for hour in 1...12 {
                let angle = Angle.degrees(Double(hour) / 12 * 360 - 90)
                let text = Text("\(hour)")
                    .font(.system(size: 12).bold())
                
                let textSize = context.resolve(text).measure(in: CGSize(width: 100, height: 100))
                let textRadius = radius * 0.8
                let textX = center.x + cos(Double(angle.radians)) * textRadius - textSize.width / 2
                let textY = center.y + sin(Double(angle.radians)) * textRadius - textSize.height / 2
                
                context.draw(text, at: CGPoint(x: textX + textSize.width / 2, y: textY + textSize.height / 2))
            }
            
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
