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

            VStack(alignment: .leading, spacing: 6) {
                Label(viewModel.currentRewardText, systemImage: "ticket.fill")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.green)

                Text(viewModel.nextRewardText)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.green.opacity(0.08), in: RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
