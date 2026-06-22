import Foundation

extension TimeInterval {
    var formattedDuration: String {
        let totalSeconds = max(Int(self), 0)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return "\(minutes)m \(seconds)s"
    }
}
