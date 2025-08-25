import Foundation

@Observable
class ScheduleViewModel{
    var test: [Schedule] = [
        .init(user_uid: "", text: "homewpork", time: "08:30"),
        .init(user_uid: "", text: "eat", time: "10:30"),
        .init(user_uid: "", text: "learn", time: "13:30"),
        .init(user_uid: "", text: "gym", time: "17:30"),
        .init(user_uid: "", text: "game", time: "19:30"),
        .init(user_uid: "", text: "sleep", time: "22:30"),
    ]
    
    func insertSchedule(user_uid: String, text: String, time: String) async throws {
        let schedule = Schedule(user_uid: user_uid, text: text, time: time)
        try await DatabaseManager.shared.insertSchedule(schedule: schedule)
    }
}
