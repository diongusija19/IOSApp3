import Foundation

final class TrailPulseViewModel: ObservableObject {
    @Published private(set) var stops: [TrailStop]
    @Published private(set) var history: [HikeSession]
    @Published private(set) var activeSession: HikeSession?

    private let store: TrailPulseStore

    init(store: TrailPulseStore = TrailPulseStore()) {
        self.store = store
        let snapshot = store.load()
        stops = snapshot.stops
        history = snapshot.history
    }

    var completedStopCount: Int {
        stops.filter(\.isComplete).count
    }

    var progress: Double {
        guard !stops.isEmpty else { return 0 }
        return Double(completedStopCount) / Double(stops.count)
    }

    var activeElapsedTime: TimeInterval {
        activeSession?.duration ?? 0
    }

    func startSession() {
        guard activeSession == nil else { return }
        activeSession = HikeSession(
            id: UUID(),
            startedAt: Date(),
            endedAt: nil,
            completedStopCount: completedStopCount,
            note: ""
        )
    }

    func finishSession(note: String = "") {
        guard var session = activeSession else { return }

        // The completed count is captured at finish time so the history reflects the final walk.
        session.endedAt = Date()
        session.completedStopCount = completedStopCount
        session.note = note.trimmingCharacters(in: .whitespacesAndNewlines)
        history.insert(session, at: 0)
        activeSession = nil
        persist()
    }

    func toggleStop(_ stop: TrailStop) {
        guard let index = stops.firstIndex(where: { $0.id == stop.id }) else { return }
        stops[index].isComplete.toggle()
        persist()
    }

    func resetToday() {
        stops = stops.map { stop in
            var updatedStop = stop
            updatedStop.isComplete = false
            return updatedStop
        }
        persist()
    }

    func clearHistory() {
        history.removeAll()
        persist()
    }

    private func persist() {
        store.save(stops: stops, history: history)
    }
}
