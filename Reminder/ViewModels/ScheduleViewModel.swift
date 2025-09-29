import Foundation

@Observable
class ScheduleViewModel{
    var scheduleView: [Schedule] = []
    
    func insertSchedule(user_uid: String, text: String, time: String) async throws {
        let schedule = Schedule(user_uid: user_uid, text: text, time: time)
        try await ScheduleOneDayManager.shared.insertSchedule(schedule: schedule)
        scheduleView.append(schedule)
    }

    func fetchSchedule(for uid: String) async throws {
        let result: [Schedule] = try await ScheduleOneDayManager.shared.fetchSchedule(for: uid)
        self.scheduleView = result
    }

    func deleteSchedule(text: String, for uid: String) async throws {
        try await ScheduleOneDayManager.shared.deleteSchedule(text: text, for: uid)
    }
}
