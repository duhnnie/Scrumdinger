import Foundation
import SwiftUI

struct HistoryView: View {
    let history: History

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)

                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
            .navigationTitle(Text(history.date, style: .date))
            .padding()
        }
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(id: UUID(), date: Date(), attendees: DailyScrum.sampleData[0].attendees, lengthInMinutes: 40, transcript: "This is a example transcript, I wrote this while I'm listening to Do While by Oval from the 94diskount. album.")
    }

    static var previews: some View {
        HistoryView(history: history)
    }
}

