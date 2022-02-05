import SwiftUI

struct DailyScrum: Identifiable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map({ Attendee(name: $0) })
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
}

extension DailyScrum {
    static let sampleData :[DailyScrum] = [
        DailyScrum(
            title: "Daily Standup",
            attendees: ["Mirko", "Quike", "Daniel"],
            lengthInMinutes: 15,
            theme: .teal
        ),
        DailyScrum(
            title: "Dev Scrum",
            attendees: ["Roberto", "Omar", "Richie", "Jona", "Daniel"],
            lengthInMinutes: 20,
            theme: .yellow
        ),
        DailyScrum(
            title: "Design Scrum",
            attendees: ["Daniel", "Enrique", "Fernando", "Julichus"],
            lengthInMinutes: 120,
            theme: .bubblegum
        )
    ]
}
