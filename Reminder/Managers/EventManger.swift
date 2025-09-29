import Foundation

class EventManger{
    static let shared = EventManger()
    
    func insertEvent(event: Event) async throws {
        let respone = try await supabase.from("events").insert(event).execute()
        print(respone.status)
    }
    
    func fetchEvent(for uid: String) async throws -> [Event] {
        let events: [Event] = try await supabase.from(
            "events"
        ).select().eq(
            "user_uid",
            value: uid
        ).order(
            "event_date",
            ascending: true
        ).execute().value
        return events
    }
    
    func deleteEvent(title: String, for uid: String) async throws {
        let response = try await supabase.from(
            "events"
        ).delete().eq(
            "title",
            value: title
        ).eq(
            "user_uid",
            value: uid
        ).execute()
        print(response.status)
    }
}
