import Foundation

@MainActor
@Observable
class ScheduleViewModel{
    var scheduleView: [Schedule] = [
        .init(user_uid: "2311", text: "Di ngu", time: "19:00"),
        .init(user_uid: "2311", text: "Di ngu", time: "20:00"),
        .init(user_uid: "2311", text: "Di ngu", time: "21:00"),
        .init(user_uid: "2311", text: "Di ngu", time: "22:00"),
        .init(user_uid: "2311", text: "Di ngu", time: "23:00"),
        .init(user_uid: "2311", text: "Di ngu", time: "24:00"),
        .init(user_uid: "2311", text: "Di ngu", time: "25:00"),
    ]
    
    func insertSchedule(user_uid: String, text: String, time: String) async throws {
        let schedule = Schedule(user_uid: user_uid, text: text, time: time)
        try await DatabaseManager.shared.insertSchedule(schedule: schedule)
        scheduleView.append(schedule)
    }
    
    func fetchSchedule(for uid: String) async throws {
        let result: [Schedule] = try await DatabaseManager.shared.fetchSchedule(for: uid)
        self.scheduleView = result
    }
    
    func deleteSchedule(text: String, for uid: String) async throws {
        try await DatabaseManager.shared.deleteSchedule(text: text, for: uid)
    }
}
