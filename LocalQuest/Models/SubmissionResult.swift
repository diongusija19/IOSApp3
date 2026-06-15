import Foundation

struct SubmissionResult: Identifiable, Codable, Equatable {
    let id: UUID
    let foundCount: Int
    let discountCode: String?
    let message: String
    let qualifiesForGrandPrize: Bool
    let submittedAt: Date

    init(
        id: UUID = UUID(),
        foundCount: Int,
        discountCode: String?,
        message: String,
        qualifiesForGrandPrize: Bool,
        submittedAt: Date = Date()
    ) {
        self.id = id
        self.foundCount = foundCount
        self.discountCode = discountCode
        self.message = message
        self.qualifiesForGrandPrize = qualifiesForGrandPrize
        self.submittedAt = submittedAt
    }
}
