import SwiftUI

struct SubmissionView: View {
    @EnvironmentObject private var viewModel: HuntViewModel

    var body: some View {
        NavigationStack {
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

                Spacer()
            }
            .padding()
            .navigationTitle("Submit")
        }
    }
}
