import SwiftUI

struct SubmissionView: View {
    @EnvironmentObject private var viewModel: HuntViewModel
    @State private var isConfirmingReset = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    ProgressHeaderView()
                        .padding(.horizontal, -16)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Online Submission")
                            .font(.title2.bold())

                        Text("Submit your photo evidence to calculate the correct discount code and grand prize eligibility.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Button {
                            Task {
                                await viewModel.submitResults()
                            }
                        } label: {
                            if viewModel.isSubmitting {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Label("Submit Results", systemImage: "paperplane.fill")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!viewModel.canSubmit)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.background, in: RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.quaternary)
                    }

                    if let result = viewModel.submissionResult {
                        SubmissionResultView(result: result)
                    }

                    if !viewModel.submissionHistory.isEmpty {
                        submissionHistory
                    }
                }
            }
            .padding()
            .navigationTitle("Submit")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        isConfirmingReset = true
                    } label: {
                        Label("Reset Hunt", systemImage: "arrow.counterclockwise")
                    }
                    .disabled(viewModel.foundCount == 0)
                }
            }
            .confirmationDialog("Reset all saved photos?", isPresented: $isConfirmingReset, titleVisibility: .visible) {
                Button("Reset Hunt", role: .destructive) {
                    viewModel.resetHunt()
                }

                Button("Cancel", role: .cancel) {}
            }
        }
    }

    private var submissionHistory: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Submission History")
                .font(.headline)

            ForEach(Array(viewModel.submissionHistory.enumerated()), id: \.element.id) { index, result in
                submissionHistoryRow(result)

                if index < viewModel.submissionHistory.count - 1 {
                    Divider()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.quaternary)
        }
    }

    private func submissionHistoryRow(_ result: SubmissionResult) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(result.foundCount) item(s) submitted")
                    .font(.subheadline.weight(.semibold))
                Text(result.submittedAt.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(result.discountCode ?? "No code")
                .font(.caption.monospaced().bold())
                .foregroundStyle(result.discountCode == nil ? Color.secondary : Color.green)
        }
        .padding(.vertical, 6)
    }
}
