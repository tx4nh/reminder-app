import SwiftUI

struct DateView: View {
    let day: Int
    @State private var isPress: Bool = false
    @State private var today = Date()
    private var isToday: Bool {
        return day == Calendar.current.component(.day, from: today)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isPress ? Color.blue : Color.gray, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isToday ? Color.blue : Color.white)
                )
                .frame(width: 45, height: 60)

            VStack(spacing: 6) {
                Text("\(day)")
                    .foregroundStyle(isToday ? .white : .gray)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack(spacing: 4) {
                    Text(weekdayAbbreviation(for: today))
                    Text(String(format: "%02d", Calendar.current.component(.month, from: today)))
                }
                .foregroundStyle(isToday ? .white : .gray)
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .onTapGesture {
            isPress.toggle()
            today = Date()
        }
    }

    private func weekdayAbbreviation(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter.string(from: date)
    }
}

#Preview {
    DateView(day: 17)
}
