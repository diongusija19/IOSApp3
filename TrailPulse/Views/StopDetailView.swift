import SwiftUI

struct StopDetailView: View {
    let stop: TrailStop
    @ObservedObject var viewModel: TrailPulseViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 14) {
                Image(systemName: stop.symbolName)
                    .font(.largeTitle)
                    .foregroundStyle(stop.isComplete ? .green : .blue)

                Text(stop.name)
                    .font(.headline)

                Text(stop.tip)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                Button(stop.isComplete ? "Mark Open" : "Complete") {
                    viewModel.toggleStop(stop)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle(stop.distanceText)
        }
    }
}
