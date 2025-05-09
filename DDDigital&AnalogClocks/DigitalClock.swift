//
//  DigitalClock.swift
//  DDDigital&AnalogClocks
//
//  Created by joe on 5/9/25.
//

import SwiftUI

struct DigitalClock: View {
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { timeline in
            let date = timeline.date
            Text(date.formatted(date: .omitted, time: .standard))
                .font(
                    .system(
                        size: 40,
                        weight: .bold,
                        design: .monospaced
                    )
                )
        }
    }
}

#Preview {
    DigitalClock()
}
