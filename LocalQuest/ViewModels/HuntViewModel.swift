import Foundation
import SwiftUI

@MainActor
final class HuntViewModel: ObservableObject {
    @Published var items: [HuntItem] = HuntViewModel.sampleItems
    @Published var isSubmitting = false
    @Published var submissionResult: SubmissionResult?

    var foundCount: Int {
        items.filter(\.isFound).count
    }

    var progressText: String {
        "\(foundCount) of \(items.count) found"
    }

    var canSubmit: Bool {
        foundCount > 0 && !isSubmitting
    }

    func addPhoto(_ data: Data, to item: HuntItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        items[index].photoData = data
    }

    func clearPhoto(for item: HuntItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        items[index].photoData = nil
    }

    func submitResults() async {
        isSubmitting = true
        submissionResult = nil

        // Simulates sending the player's photo evidence to an online submission endpoint.
        try? await Task.sleep(for: .seconds(1))

        submissionResult = makeSubmissionResult()
        isSubmitting = false
    }

    private func makeSubmissionResult() -> SubmissionResult {
        switch foundCount {
        case 10:
            return SubmissionResult(
                foundCount: foundCount,
                discountCode: "LOCAL20",
                message: "Excellent hunt! You earned 20% off and an entry into the $5000 grand prize draw.",
                qualifiesForGrandPrize: true
            )
        case 7...9:
            return SubmissionResult(
                foundCount: foundCount,
                discountCode: "LOCAL20",
                message: "Great work! You earned a 20% discount code.",
                qualifiesForGrandPrize: false
            )
        case 5...6:
            return SubmissionResult(
                foundCount: foundCount,
                discountCode: "LOCAL10",
                message: "Nice job! You earned a 10% discount code.",
                qualifiesForGrandPrize: false
            )
        default:
            return SubmissionResult(
                foundCount: foundCount,
                discountCode: nil,
                message: "Thanks for submitting. Find at least 5 items to unlock a discount code.",
                qualifiesForGrandPrize: false
            )
        }
    }

    static let sampleItems: [HuntItem] = [
        HuntItem(id: 1, businessName: "Harbour Bean Cafe", businessType: "Restaurant", clue: "Look where morning orders start and the daily specials are written by hand.", prizeHint: "Coffee coupon", symbolName: "cup.and.saucer.fill", accentColor: .brown),
        HuntItem(id: 2, businessName: "Galaxy Cinema", businessType: "Movie Theatre", clue: "Find the item near a poster for a movie that has not started yet.", prizeHint: "Popcorn upgrade", symbolName: "movieclapper.fill", accentColor: .red),
        HuntItem(id: 3, businessName: "Page Turner Books", businessType: "Book Store", clue: "Search beside the shelf where mystery readers start their next case.", prizeHint: "Bookmark prize", symbolName: "book.closed.fill", accentColor: .indigo),
        HuntItem(id: 4, businessName: "Maple Street Bakery", businessType: "Bakery", clue: "The sweetest clue is close to the glass case, but never inside it.", prizeHint: "Pastry deal", symbolName: "birthday.cake.fill", accentColor: .pink),
        HuntItem(id: 5, businessName: "Downtown Sports", businessType: "Sporting Goods", clue: "Check near the display where runners compare shoes before race day.", prizeHint: "Gear discount", symbolName: "figure.run", accentColor: .green),
        HuntItem(id: 6, businessName: "Vinyl Corner", businessType: "Music Shop", clue: "Spin toward the classics section and look for the staff pick label.", prizeHint: "Sticker pack", symbolName: "music.note.list", accentColor: .mint),
        HuntItem(id: 7, businessName: "Art Loft Studio", businessType: "Art Studio", clue: "Find it where blank canvases wait for their first color.", prizeHint: "Workshop raffle", symbolName: "paintpalette.fill", accentColor: .orange),
        HuntItem(id: 8, businessName: "Green Thumb Florist", businessType: "Florist", clue: "The item is tucked near blooms that smell like spring rain.", prizeHint: "Bouquet deal", symbolName: "leaf.fill", accentColor: .teal),
        HuntItem(id: 9, businessName: "Pixel Palace Arcade", businessType: "Arcade", clue: "Look close to the game with the brightest high-score board.", prizeHint: "Token bonus", symbolName: "gamecontroller.fill", accentColor: .purple),
        HuntItem(id: 10, businessName: "Community Market", businessType: "Market", clue: "Head to the local honey and preserves table for the final clue.", prizeHint: "Market voucher", symbolName: "basket.fill", accentColor: .yellow)
    ]
}
