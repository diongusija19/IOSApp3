import SwiftUI

struct SubmissionResultView: View {
    let result: SubmissionResult

    private var submittedDate: String {
        result.submittedAt.formatted(date: .abbreviated, time: .shortened)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Submission Received", systemImage: "checkmark.circle.fill")
                .font(.headline)
                .foregroundStyle(.green)

            Text(submittedDate)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(result.message)
                .font(.subheadline)

            if let code = result.discountCode {
                HStack {
                    Text("Code")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(code)
                        .font(.title3.monospaced().bold())
                }
                .padding()
                .background(.green.opacity(0.10), in: RoundedRectangle(cornerRadius: 8))
            }

            if result.qualifiesForGrandPrize {
                Label("$5000 grand prize draw entry unlocked", systemImage: "trophy.fill")
                    .foregroundStyle(.orange)
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
}
