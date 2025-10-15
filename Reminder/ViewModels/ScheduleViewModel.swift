import Foundation

@Observable
class ScheduleViewModel{
    var scheduleView: [Schedule] = []
    
    func insertSchedule(schedule: Schedule) async throws {
        try await ScheduleOneDayManager.shared.insertSchedule(schedule: schedule)
        scheduleView.append(schedule)
    }

    func fetchSchedule(for uid: String, date: String) async throws {
        let result: [Schedule] = try await ScheduleOneDayManager.shared.fetchSchedule(for: uid, date: date)
        self.scheduleView = result
    }

    func deleteSchedule(text: String, for uid: String, date: String) async throws {
        try await ScheduleOneDayManager.shared.deleteSchedule(text: text, for: uid, date: date)
    }
}

extension Date {
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    func toTimeString() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return String(format: "%02d:%02d", hour, minute)
    }
    
    func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "vi_VN")
        return formatter.string(from: self)
    }
}

