import SwiftUI

struct ContributionGraphView: View {
    let entries: [HabitEntry]
    let columns = 7
    let rows = 7
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Activity")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: columns), spacing: 4) {
                ForEach(0..<rows * columns, id: \.self) { index in
                    let date = Calendar.current.date(byAdding: .day, value: -(rows * columns - index - 1), to: Date()) ?? Date()
                    let entry = entries.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(colorForCount(entry?.count ?? 0))
                        .frame(height: 20)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
    
    private func colorForCount(_ count: Int) -> Color {
        switch count {
        case 0: return Color.gray.opacity(0.1)
        case 1: return Color.black.opacity(0.2)
        case 2: return Color.black.opacity(0.4)
        case 3: return Color.black.opacity(0.6)
        default: return Color.black.opacity(0.8)
        }
    }
} 