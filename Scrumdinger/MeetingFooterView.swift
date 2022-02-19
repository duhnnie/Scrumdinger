import Foundation
import SwiftUI

struct MeetingFoooterView: View {
    var speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void

    var speakerNumber: Int? {
        guard let firstNotCompleted = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }

        return firstNotCompleted + 1
    }

    var isLastSpeaker: Bool {
        speakers.dropLast().allSatisfy{ $0.isCompleted }
    }

    var allSpeakersTalked: Bool {
        guard speakerNumber == nil else {
            return false
        }
        return true
    }

    private var speakerText: String {
        if allSpeakersTalked {
            return "No more speakers"
        } else if isLastSpeaker {
            return "Last speaker"
        }

        return "Speaker \(speakerNumber!) of \(speakers.count)"
    }

    var body: some View {
        VStack {
            HStack {
                Text(speakerText)
                Spacer()

                if (!allSpeakersTalked && !isLastSpeaker) {
                    Button(action: skipAction){
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }

            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFoooterView(
            speakers: DailyScrum.sampleData[0].attendees.speakers,
            skipAction: {}
        )
    }
}
