import SwiftUI

struct StopsView: View {
    @ObservedObject var viewModel: TrailPulseViewModel
    @State private var selectedStop: TrailStop?

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.stops) { stop in
                    Button {
                        selectedStop = stop
                    } label: {
                        StopRow(stop: stop)
                    }
                }
            }
            .navigationTitle("Stops")
            .toolbar {
                Button {
                    viewModel.resetToday()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .accessibilityLabel("Reset stops")
            }
            .sheet(item: $selectedStop) { stop in
                StopDetailView(stop: stop, viewModel: viewModel)
            }
        }
    }
}

private struct StopRow: View {
    let stop: TrailStop

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: stop.symbolName)
                .foregroundStyle(stop.isComplete ? .green : .blue)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(stop.name)
                    .font(.headline)
                Text(stop.distanceText)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: stop.isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(stop.isComplete ? .green : .secondary)
        }
    }
}
