import Foundation

struct Schedule: Codable {
    let user_uid: String
    var text: String
    var time: String
}

class DatabaseManager{
    static let shared = DatabaseManager()
    
    func insertSchedule(schedule: Schedule) async throws {
        let response = try await supabase.from("schedules").insert(schedule).execute()
        print(response.status)
    }
    
//    func fetchSchedule(schedule: Schedule) async throws {
//        let sche: [Schedule] = try await supabase.from("schedules").select().execute().value
//    }
}
