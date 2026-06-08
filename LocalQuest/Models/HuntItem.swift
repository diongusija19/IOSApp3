import Foundation
import SwiftUI

struct HuntItem: Identifiable, Equatable {
    let id: Int
    let businessName: String
    let businessType: String
    let clue: String
    let prizeHint: String
    let symbolName: String
    let accentColor: Color
    var photoData: Data?

    var isFound: Bool {
        photoData != nil
    }
}
