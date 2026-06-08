import SwiftUI

@main
struct LocalQuestApp: App {
    @StateObject private var huntViewModel = HuntViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(huntViewModel)
        }
    }
}
