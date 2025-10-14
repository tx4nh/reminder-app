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
