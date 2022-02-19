import Foundation

class ScrumTimer: ObservableObject {
    struct Speaker: Identifiable {
        let id = UUID()
        let name: String
        var isCompleted: Bool
    }

    @Published var activeSpeaker = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0

    private(set) var lengthInMinutes: Int
    private(set) var speakers: [Speaker] = []

    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var speakerIndex: Int = 0
    private var speakerText: String { "Speaker \(speakerIndex + 1): \(speakers[speakerIndex].name)" }
    private var secondsElapsedForSpeaker: Int = 0
    private var secondsPerSpeaker: Int { lengthInSeconds / speakers.count }
    private var startDate: Date?
    private var timer: Timer?
    private var frecuency: TimeInterval { 1.0 / 60.0 }
    private var timerStopped = false

    var speakerChangedAction: (() -> Void)?

    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }

    func startScrum() {
        changeToSpeaker(at: 0)
    }

    func stopScrum() {
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }

    func skipSpeaker() {
        changeToSpeaker(at: speakerIndex + 1)
    }

    func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1

            speakers[previousSpeakerIndex].isCompleted = true
        }

        secondsElapsedForSpeaker = 0
        guard index < speakers.count else { return }
        speakerIndex = index
        activeSpeaker = speakerText

        secondsElapsed = secondsPerSpeaker * index
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frecuency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                self.update(secondsElapsed: Int(secondsElapsed))
            }
        }
    }

    private func update(secondsElapsed: Int) {
        secondsElapsedForSpeaker = secondsElapsed
        self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsed
        guard secondsElapsed <= secondsPerSpeaker else {
            return
        }
        secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

        guard !timerStopped else { return }

        if secondsElapsedForSpeaker >= secondsPerSpeaker {
            changeToSpeaker(at: speakerIndex + 1)
            speakerChangedAction?()
        }
    }

    func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}

extension DailyScrum {
    var timer: ScrumTimer {
        ScrumTimer(lengthInMinutes: lengthInMinutes, attendees: attendees)
    }
}

extension Array where Element == DailyScrum.Attendee {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1", isCompleted: false)]
        } else {
            return self.map { ScrumTimer.Speaker(name: $0.name, isCompleted: false) }
        }
    }
}
