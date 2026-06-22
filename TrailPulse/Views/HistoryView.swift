import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: TrailPulseViewModel

    var body: some View {
        NavigationStack {
            List {
                if viewModel.history.isEmpty {
                    ContentUnavailableView(
                        "No Sessions",
                        systemImage: "figure.hiking",
                        description: Text("Finish a hike to save it here.")
                    )
                } else {
                    ForEach(viewModel.history) { session in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(session.startedAt, style: .date)
                                .font(.headline)
                            Text("\(session.duration.formattedDuration) • \(session.completedStopCount) stops")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            if !session.note.isEmpty {
                                Text(session.note)
                                    .font(.caption2)
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
            .toolbar {
                if !viewModel.history.isEmpty {
                    Button {
                        viewModel.clearHistory()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .accessibilityLabel("Clear history")
                }
            }
        }
    }
}
