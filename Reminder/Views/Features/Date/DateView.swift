import SwiftUI

struct DateView: View {
    let offset: Int
    let isSelected: Bool
    let baseDate: Date
    @Environment(AppLanguageManager.self) var appLanguage

    private var displayDate: Date {
        Calendar.current.date(byAdding: .day, value: offset, to: baseDate) ?? baseDate
    }
    
    private var isToday: Bool {
        offset == 0
    }
    
    private var day: Int {
        Calendar.current.component(.day, from: displayDate)
    }
    
    private var month: Int {
        Calendar.current.component(.month, from: displayDate)
    }
    
    private func weekdayAbbreviation(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        formatter.locale = Locale(identifier: appLanguage.language.rawValue)
        return formatter.string(from: date)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isToday ? Color.blue : isSelected ? Color.blue : Color.gray, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isToday ? Color.blue : isSelected ? .blue.opacity(0.3) : Color(uiColor: .systemBackground))
                )
                .frame(width: 50, height: 60)

            VStack(spacing: 6) {
                Text(String(format: "%02d", day))
                    .foregroundStyle(isToday ? .white : isSelected ? .blue : .gray)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack(spacing: 4) {
                    Text(weekdayAbbreviation(for: displayDate))
                    Text(String(format: "%02d", month))
                }
                .foregroundStyle(isToday ? .white : isSelected ? .blue : .gray)
                .font(.caption)
            }
        }
    }
}

#Preview {
    DateView(offset: 0, isSelected: true, baseDate: Date()).environment(AppLanguageManager())
}
