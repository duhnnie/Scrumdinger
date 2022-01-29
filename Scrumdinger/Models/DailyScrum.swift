struct DailyScrum {
    var title: String
    var atendees: [String]
    var lengthInMinutes: Int
    var theme: Theme
}

extension DailyScrum {
    static let sampleData :[DailyScrum] = [
        DailyScrum(
            title: "Daily Standup",
            atendees: ["Mirko", "Quike", "Daniel"],
            lengthInMinutes: 15,
            theme: .purple
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
