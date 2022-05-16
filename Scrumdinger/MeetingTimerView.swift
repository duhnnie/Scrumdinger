import Foundation
import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    let isRecording: Bool

    private var currentSpeaker: String {
        speakers.first { !$0.isCompleted }?.name ?? "Someone"
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .foregroundColor(theme.accentColor)
                .accessibilityElement(children: .combine)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(totalSpeakers: speakers.count, speakerIndex: index)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12.0)
                    }
                }
            }
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static let speakers = [
        ScrumTimer.Speaker(name: "Daniel", isCompleted: true),
        ScrumTimer.Speaker(name: "David", isCompleted: true),
        ScrumTimer.Speaker(name: "Pilar", isCompleted: false),
        ScrumTimer.Speaker(name: "Ramona", isCompleted: false)
    ]

    static var previews: some View {
        MeetingTimerView(speakers: speakers, theme: .yellow, isRecording: true)
    }
}
