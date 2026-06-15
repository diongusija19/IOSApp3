import Foundation
import SwiftUI

@MainActor
final class HuntViewModel: ObservableObject {
    @Published var items: [HuntItem]
    @Published var isSubmitting = false
    @Published var submissionResult: SubmissionResult?
    @Published var submissionHistory: [SubmissionResult]

    private let progressStore: HuntProgressStore

    init(progressStore: HuntProgressStore = HuntProgressStore()) {
        self.progressStore = progressStore

        let savedPhotos = progressStore.loadPhotos()
        items = HuntViewModel.sampleItems.map { item in
            var restoredItem = item
            restoredItem.photoData = savedPhotos[item.id]
            return restoredItem
        }
        submissionHistory = progressStore.loadSubmissions()
    }

    var foundCount: Int {
        items.filter(\.isFound).count
    }

    var progressText: String {
        "\(foundCount) of \(items.count) found"
    }

    var canSubmit: Bool {
        foundCount > 0 && !isSubmitting
    }

    var nextRewardText: String {
        switch foundCount {
        case 0...4:
            return "Find \(5 - foundCount) more item(s) to unlock a 10% discount."
        case 5...6:
            return "Find \(7 - foundCount) more item(s) to upgrade to 20% off."
        case 7...9:
            return "Find \(10 - foundCount) more item(s) to enter the $5000 grand prize draw."
        default:
            return "All rewards unlocked. Submit your hunt for final review."
        }
    }

    var currentRewardText: String {
        switch foundCount {
        case 10:
            return "20% discount + grand prize entry"
        case 7...9:
            return "20% discount"
        case 5...6:
            return "10% discount"
        default:
            return "No discount yet"
        }
    }

    func addPhoto(_ data: Data, to item: HuntItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        items[index].photoData = data
        submissionResult = nil
        saveProgress()
    }

    func clearPhoto(for item: HuntItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        items[index].photoData = nil
        submissionResult = nil
        saveProgress()
    }

    func resetHunt() {
        items = items.map { item in
            var resetItem = item
            resetItem.photoData = nil
            return resetItem
        }
        submissionResult = nil
        saveProgress()
    }

    func submitResults() async {
        isSubmitting = true
        submissionResult = nil

        // This simulates the online handoff. A real app would upload each proof photo,
        // then trust the server to verify images before returning the final reward.
        try? await Task.sleep(for: .seconds(1))

        let result = makeSubmissionResult()
        submissionResult = result
        submissionHistory.insert(result, at: 0)
        saveProgress()
        isSubmitting = false
    }

    private func saveProgress() {
        let photosByItemID: [Int: Data] = Dictionary(uniqueKeysWithValues: items.compactMap { item -> (Int, Data)? in
            guard let photoData = item.photoData else {
                return nil
            }

            return (item.id, photoData)
        })

        progressStore.save(photosByItemID: photosByItemID, submissions: submissionHistory)
    }

    private func makeSubmissionResult() -> SubmissionResult {
        // Reward tiers come directly from the assignment brief.
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
