import Foundation

@MainActor
@Observable
class ScheduleViewModel{
    var scheduleView: [Schedule] = [
    ]
    
    func insertSchedule(user_uid: String, text: String, time: String) async throws {
        let schedule = Schedule(user_uid: user_uid, text: text, time: time)
        try await DatabaseManager.shared.insertSchedule(schedule: schedule)
        scheduleView.append(schedule)
//        scheduleView.sort{$0.time < $1.time}
    }
    
    func fetchSchedule(for uid: String) async throws {
        let result: [Schedule] = try await DatabaseManager.shared.fetchSchedule(for: uid)
        self.scheduleView = result
    }
}
