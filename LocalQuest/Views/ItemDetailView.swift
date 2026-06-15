import SwiftUI

struct ItemDetailView: View {
    @EnvironmentObject private var viewModel: HuntViewModel
    let item: HuntItem

    @State private var isShowingCamera = false
    @State private var capturedImage: UIImage?

    private var latestItem: HuntItem {
        viewModel.items.first(where: { $0.id == item.id }) ?? item
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                clueCard
                photoCard
            }
            .padding()
        }
        .navigationTitle(item.businessName)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingCamera) {
            CameraPicker(image: $capturedImage)
        }
        .onChange(of: capturedImage) { newImage in
            guard let data = newImage?.jpegData(compressionQuality: 0.8) else {
                return
            }

            viewModel.addPhoto(data, to: item)
            capturedImage = nil
        }
    }

    private var clueCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(item.businessType, systemImage: item.symbolName)
                .font(.headline)
                .foregroundStyle(item.accentColor)

            Text(item.clue)
                .font(.title3.weight(.semibold))

            Label(item.prizeHint, systemImage: "gift.fill")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(item.accentColor.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
    }

    private var photoCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Proof Photo")
                .font(.headline)

            if let photoData = latestItem.photoData, let image = UIImage(data: photoData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                HStack {
                    Button {
                        isShowingCamera = true
                    } label: {
                        Label("Retake Photo", systemImage: "arrow.triangle.2.circlepath.camera")
                    }
                    .buttonStyle(.borderedProminent)

                    Button(role: .destructive) {
                        viewModel.clearPhoto(for: item)
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                VStack(spacing: 10) {
                    Image(systemName: "camera.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("No Photo Yet")
                        .font(.headline)
                    Text("Take a picture of the hidden item after you find it.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)

                Button {
                    isShowingCamera = true
                } label: {
                    Label("Take Photo", systemImage: "camera.fill")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.quaternary)
        }
    }
}
