import SwiftUI

struct HuntItemRowView: View {
    let item: HuntItem

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.symbolName)
                .font(.title3)
                .foregroundStyle(item.accentColor)
                .frame(width: 36, height: 36)
                .background(item.accentColor.opacity(0.14), in: RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 3) {
                Text(item.businessName)
                    .font(.headline)
                Text(item.businessType)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: item.isFound ? "checkmark.seal.fill" : "camera")
                .foregroundStyle(item.isFound ? .green : .secondary)
                .accessibilityLabel(item.isFound ? "Found" : "Needs photo")
        }
        .padding(.vertical, 4)
    }
}
