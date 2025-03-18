import Foundation

struct HabitEntry: Codable, Identifiable {
    let id: UUID
    let date: Date
    let count: Int
    
    init(id: UUID = UUID(), date: Date = Date(), count: Int = 1) {
        self.id = id
        self.date = date
        self.count = count
    }
}

class HabitStore: ObservableObject {
    @Published var entries: [HabitEntry] = []
    private let saveKey = "habitEntries"
    
    init() {
        loadEntries()
    }
    
    func addEntry() {
        let today = Calendar.current.startOfDay(for: Date())
        if let existingIndex = entries.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
            // Update existing entry
            let existingEntry = entries[existingIndex]
            entries[existingIndex] = HabitEntry(id: existingEntry.id, date: existingEntry.date, count: existingEntry.count + 1)
        } else {
            // Add new entry
            entries.append(HabitEntry(date: today))
        }
        saveEntries()
    }
    
    func getCurrentStreak() -> Int {
        let today = Calendar.current.startOfDay(for: Date())
        var streak = 0
        var currentDate = today
        
        while entries.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }) {
            streak += 1
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
        }
        
        return streak
    }
    
    private func saveEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadEntries() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([HabitEntry].self, from: data) {
            entries = decoded
        }
    }
} 