import Foundation

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
    
    func deleteSchedule(text: String, for uid: String) async throws {
        let response = try await supabase.from(
            "schedules"
        ).delete().eq(
            "text",
            value: text
        ).eq(
            "user_uid",
            value: uid
        ).execute()
        print(response.status)
    }
}
