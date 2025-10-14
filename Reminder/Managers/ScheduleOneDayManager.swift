import Foundation

class ScheduleOneDayManager{
    static let shared = ScheduleOneDayManager()
    
    func insertSchedule(schedule: Schedule) async throws {
        let response = try await supabase.from("schedules").insert(schedule).execute()
        print(response.status)
    }
    
    func fetchSchedule(for uid: String, date: String) async throws -> [Schedule] {
        let schedule: [Schedule] = try await supabase.from(
            "schedules"
        ).select().eq(
            "user_uid",
            value: uid
        ).eq(
            "date",
            value: date
        ).order(
            "time",
            ascending: true
        ).execute().value
        return schedule
    }
    
    func deleteSchedule(text: String, for uid: String, date: String) async throws {
        let response = try await supabase.from(
            "schedules"
        ).delete().eq(
            "text",
            value: text
        ).eq(
            "user_uid",
            value: uid
        ).eq(
            "date",
            value: date
        ).execute()
        print(response.status)
    }
}
