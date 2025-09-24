import SwiftUI

struct DateView: View {
    let day: Int
    @State private var isPress: Bool = false
    @State private var today = Date()

    private var isToday: Bool {
        return day == Calendar.current.component(.day, from: today)
    }
    
    private var dateForDay: Date? {
        var components = Calendar.current.dateComponents([.year, .month], from: today)
        components.day = 1
        guard let firstDayOfMonth = Calendar.current.date(from: components) else {
            return nil
        }
        return Calendar.current.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)
    }
    
    private func weekdayAbbreviation(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter.string(from: date)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isToday ? Color.blue : isPress ? Color.blue : Color.gray, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isToday ? Color.blue : Color.white)
                )
                .frame(width: 48, height: 60)

            VStack(spacing: 6) {
                Text(String(format: "%02d", Calendar.current.component(.day, from: dateForDay ?? today)))
                    .foregroundStyle(isToday ? .white : .gray)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack(spacing: 4) {
                    Text(weekdayAbbreviation(for: dateForDay ?? today))
                    Text(String(format: "%02d", Calendar.current.component(.month, from: dateForDay ?? today)))
                }
                .foregroundStyle(isToday ? .white : .gray)
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .onTapGesture {
            isPress.toggle()
        }
    }
}

#Preview {
    DateView(day: 61)
}
