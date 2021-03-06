import Foundation

class ScrumStore: ObservableObject {
    private static let scrumFile: String = "scrums.data"
    @Published var scrums: [DailyScrum] = [] // DailyScrum.sampleData

    static private func getFileURL() throws -> URL {
        return try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent(scrumFile)
    }

    static func load(onCompletion: @escaping (Result<[DailyScrum], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try getFileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        onCompletion(.success([]))
                    }
                    return
                }

                let scrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)

                DispatchQueue.main.async {
                    onCompletion(.success(scrums))
                }
            } catch {
                DispatchQueue.main.async {
                    onCompletion(.failure(error))
                }
            }
        }
    }

    static func load() async throws -> [DailyScrum] {
        try await withCheckedThrowingContinuation { continuation in
            ScrumStore.load { result in
                switch(result) {
                case .success(let scrums):
                    continuation.resume(returning: scrums)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    static func save(scrums: [DailyScrum], onCompletion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(scrums)
                try data.write(to: getFileURL())

                DispatchQueue.main.async {
                    onCompletion(.success(scrums.count))
                }
            } catch {
                DispatchQueue.main.async {
                    onCompletion(.failure(error))
                }
            }

        }
    }

    @discardableResult
    static func save(scrums: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation{ continuation in
            save(scrums: scrums) { result in
                switch(result) {
                case .success(let count):
                    continuation.resume(returning: count)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
