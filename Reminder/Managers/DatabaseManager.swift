import Foundation

struct Schedule: Codable {
    let user_uid: String
    var text: String
    var time: String
    
    var displayTime: String {
        String(time.prefix(5)) // "08:30:00" -> "08:30"
    }
}

class DatabaseManager{
    static let shared = DatabaseManager()
    
    func insertSchedule(schedule: Schedule) async throws {
        let response = try await supabase.from("schedules").insert(schedule).execute()
        print(response.status)
    }
    
    func fetchSchedule(for uid: String) async throws -> [Schedule] {
        let schedule: [Schedule] = try await supabase.from(
            "schedules"
        ).select().eq(
            "user_uid",
            value: uid
        ).order(
            "time",
            ascending: true
        ).execute().value
        return schedule
    }
}
