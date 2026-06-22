import SwiftUI

struct FinishSessionView: View {
    @ObservedObject var viewModel: TrailPulseViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Trail Note") {
                    TextField("How did it feel?", text: $note)
                }

                Button("Save Session") {
                    viewModel.finishSession(note: note)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Finish")
        }
    }
}
