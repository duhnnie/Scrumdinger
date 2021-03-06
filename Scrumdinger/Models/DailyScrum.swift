import SwiftUI

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map({ Attendee(name: $0) })
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme:Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }

    init(data: Data) {
        self.init(
            title: data.title,
            attendees: data.attendees.map{ $0.name },
            lengthInMinutes: Int(data.lengthInMinutes),
            theme: data.theme
        )
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
