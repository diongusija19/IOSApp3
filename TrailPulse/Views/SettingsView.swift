import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: TrailPulseViewModel
    @AppStorage("dailyGoalMinutes") private var dailyGoalMinutes = 30
    @AppStorage("hapticRemindersEnabled") private var hapticRemindersEnabled = true

    var body: some View {
        NavigationStack {
            Form {
                Section("Daily Goal") {
                    Stepper("\(dailyGoalMinutes) min", value: $dailyGoalMinutes, in: 10...120, step: 5)
                }

                Section("Reminders") {
                    Toggle("Haptics", isOn: $hapticRemindersEnabled)
                }

                Section("Today") {
                    Text("\(viewModel.completedStopCount) stops complete")
                    ProgressView(value: viewModel.progress)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
