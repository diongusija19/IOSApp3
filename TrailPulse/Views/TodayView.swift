import SwiftUI

struct TodayView: View {
    @ObservedObject var viewModel: TrailPulseViewModel
    @AppStorage("dailyGoalMinutes") private var dailyGoalMinutes = 30
    @State private var isAddingNote = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    TimelineView(.periodic(from: Date(), by: 1)) { context in
                        let elapsed = viewModel.activeSession?.startedAt.distance(to: context.date) ?? 0
                        SessionCard(
                            isActive: viewModel.activeSession != nil,
                            elapsed: elapsed,
                            goalMinutes: dailyGoalMinutes,
                            progress: viewModel.progress
                        )
                    }

                    Button(viewModel.activeSession == nil ? "Start Hike" : "Finish Hike") {
                        if viewModel.activeSession == nil {
                            viewModel.startSession()
                        } else {
                            isAddingNote = true
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    MetricRow(
                        completed: viewModel.completedStopCount,
                        total: viewModel.stops.count
                    )
                }
                .padding(.horizontal)
            }
            .navigationTitle("TrailPulse")
            .sheet(isPresented: $isAddingNote) {
                FinishSessionView(viewModel: viewModel)
            }
        }
    }
}

private struct SessionCard: View {
    let isActive: Bool
    let elapsed: TimeInterval
    let goalMinutes: Int
    let progress: Double

    var body: some View {
        VStack(spacing: 8) {
            Gauge(value: min(elapsed / Double(goalMinutes * 60), 1)) {
                Text(isActive ? "Moving" : "Ready")
            } currentValueLabel: {
                Text(elapsed.formattedDuration)
                    .font(.headline)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(isActive ? .green : .blue)

            Text("\(Int(progress * 100))% stops")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct MetricRow: View {
    let completed: Int
    let total: Int

    var body: some View {
        HStack {
            Label("\(completed)/\(total)", systemImage: "checkmark.circle.fill")
            Spacer()
            Label("Goal", systemImage: "target")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}
