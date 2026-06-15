import Foundation

struct HuntProgressStore {
    // Only player progress is encoded. The hunt item list stays in HuntViewModel
    // so business names, clues, and symbols remain easy to edit for the assignment.
    private struct SavedProgress: Codable {
        var photosByItemID: [Int: Data]
        var submissions: [SubmissionResult]
    }

    private let fileURL: URL

    init(fileManager: FileManager = .default) {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        fileURL = documentsDirectory.appendingPathComponent("LocalQuestProgress.json")
    }

    func loadPhotos() -> [Int: Data] {
        loadProgress().photosByItemID
    }

    func loadSubmissions() -> [SubmissionResult] {
        loadProgress().submissions
    }

    func save(photosByItemID: [Int: Data], submissions: [SubmissionResult]) {
        let progress = SavedProgress(photosByItemID: photosByItemID, submissions: submissions)

        do {
            let data = try JSONEncoder().encode(progress)
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print("Unable to save LocalQuest progress: \(error)")
        }
    }

    private func loadProgress() -> SavedProgress {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(SavedProgress.self, from: data)
        } catch {
            return SavedProgress(photosByItemID: [:], submissions: [])
        }
    }
}
