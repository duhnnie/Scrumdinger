import SwiftUI

struct SpeakerArc: Shape {
    let totalSpeakers: Int
    let speakerIndex: Int

    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }

    private var startAngle: Angle {
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }

    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }

    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.width, rect.height) - 24.0
        let radius = diameter / 2.0
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)

        return Path { rect in
            rect.addArc(center: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
