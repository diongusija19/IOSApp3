import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TrailPulseViewModel

    var body: some View {
        TabView {
            TodayView(viewModel: viewModel)
            StopsView(viewModel: viewModel)
            HistoryView(viewModel: viewModel)
            SettingsView(viewModel: viewModel)
        }
        .tabViewStyle(.verticalPage)
    }
}
