import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: HuntViewModel

    var body: some View {
        TabView {
            NavigationStack {
                HuntListView()
            }
            .tabItem {
                Label("Hunt", systemImage: "map.fill")
            }

            SubmissionView()
                .tabItem {
                    Label("Submit", systemImage: "paperplane.fill")
                }
        }
        .tint(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HuntViewModel())
    }
}
