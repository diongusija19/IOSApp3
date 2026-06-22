import SwiftUI

@main
struct TrailPulseApp: App {
    @StateObject private var viewModel = TrailPulseViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
