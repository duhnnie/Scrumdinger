import SwiftUI

struct DailyScrum: Identifiable {
    let id: UUID
    var title: String
    var atendees: [String]
    var lengthInMinutes: Int
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, atendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.atendees = atendees
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    static let sampleData :[DailyScrum] = [
        DailyScrum(
            title: "Daily Standup",
            atendees: ["Mirko", "Quike", "Daniel"],
            lengthInMinutes: 15,
            theme: .orange
        ),
        DailyScrum(
            title: "Dev Scrum",
            atendees: ["Roberto", "Omar", "Richie", "Jona", "Daniel"],
            lengthInMinutes: 20,
            theme: .navy
        ),
        DailyScrum(
            title: "Design Scrum",
            atendees: ["Daniel", "Enrique", "Fernando", "Julichus"],
            lengthInMinutes: 120,
            theme: .indigo
        )
    ]
}
