import Foundation

struct TrailStop: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let symbolName: String
    let distanceText: String
    let tip: String
    var isComplete: Bool

    static let sampleStops: [TrailStop] = [
        TrailStop(
            id: UUID(uuidString: "0B138244-95EC-42F5-946B-91188C9B5481")!,
            name: "Warmup Gate",
            symbolName: "figure.walk",
            distanceText: "0.2 km",
            tip: "Start gently and check your watch fit before the trail gets busy.",
            isComplete: false
        ),
        TrailStop(
            id: UUID(uuidString: "8744D06A-A8B1-42E2-8E9E-C7CE2F89440F")!,
            name: "Lookout Bend",
            symbolName: "binoculars",
            distanceText: "0.8 km",
            tip: "Pause for a breathing reset and scan the route ahead.",
            isComplete: false
        ),
        TrailStop(
            id: UUID(uuidString: "C3F98A02-D06A-4D3F-95DF-48753E7D903D")!,
            name: "Hydration Rock",
            symbolName: "drop.fill",
            distanceText: "1.4 km",
            tip: "Take a water break before pushing toward the final marker.",
            isComplete: false
        ),
        TrailStop(
            id: UUID(uuidString: "607A9F1E-1875-4768-B877-08B9340292B1")!,
            name: "Summit Marker",
            symbolName: "flag.checkered",
            distanceText: "2.0 km",
            tip: "Log the finish, stretch your calves, and enjoy the view.",
            isComplete: false
        )
    ]
}
