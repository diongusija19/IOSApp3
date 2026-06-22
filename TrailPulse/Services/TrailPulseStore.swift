import Foundation

struct TrailPulseSnapshot: Codable {
    var stops: [TrailStop]
    var history: [HikeSession]
}

final class TrailPulseStore {
    private let storageKey = "trailPulse.snapshot"
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() -> TrailPulseSnapshot {
        guard
            let data = defaults.data(forKey: storageKey),
            let snapshot = try? JSONDecoder().decode(TrailPulseSnapshot.self, from: data)
        else {
            return TrailPulseSnapshot(stops: TrailStop.sampleStops, history: [])
        }

        return snapshot
    }

    func save(stops: [TrailStop], history: [HikeSession]) {
        // A single snapshot keeps the watch app's tiny data model easy to restore atomically.
        let snapshot = TrailPulseSnapshot(stops: stops, history: history)
        guard let data = try? JSONEncoder().encode(snapshot) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
