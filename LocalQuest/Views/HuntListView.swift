import SwiftUI

struct HuntListView: View {
    @EnvironmentObject private var viewModel: HuntViewModel

    var body: some View {
        List {
            Section {
                ProgressHeaderView()
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }

            Section("Participating Businesses") {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        ItemDetailView(item: item)
                    } label: {
                        HuntItemRowView(item: item)
                    }
                }
            }
        }
        .navigationTitle("LocalQuest")
    }
}

struct HuntListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HuntListView()
                .environmentObject(HuntViewModel())
        }
    }
}
