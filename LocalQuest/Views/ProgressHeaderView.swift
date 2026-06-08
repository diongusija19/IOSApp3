import SwiftUI

struct ProgressHeaderView: View {
    @EnvironmentObject private var viewModel: HuntViewModel

    private var progress: Double {
        Double(viewModel.foundCount) / Double(viewModel.items.count)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Chamber Scavenger Hunt")
                        .font(.title2.bold())
                    Text(viewModel.progressText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(Int(progress * 100))%")
                    .font(.title3.monospacedDigit().bold())
                    .foregroundStyle(.green)
            }

            ProgressView(value: progress)
                .tint(.green)

            Text("Photograph hidden items at local businesses. Submit at least 5 finds for 10% off, 7 for 20% off, and all 10 for the grand prize draw.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.green.opacity(0.08), in: RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
