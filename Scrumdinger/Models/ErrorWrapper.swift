import Foundation

struct ErrorWrapper: Identifiable {
    var id: UUID
    var error: Error
    var guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
