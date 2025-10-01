import Foundation
import Swift

@Observable
class EventViewModel{
    var allEvents: [Event] = []
        
    var yearlyEvents: [Event] {
        allEvents.filter { $0.eventType == "yearly" }
    }
    
    var weeklyEvents: [Event] {
        allEvents.filter { $0.eventType == "weekly" }
    }
    
    func insertEvent(user_uid: String, title: String, event_date: Date, event_type: String, repeat_day: Int?) async throws {
        let event = Event(
            id: nil,
            userID: user_uid,
            title: title,
            eventDateString: ISO8601DateFormatter().string(from: event_date),
            eventType: event_type,
            repeatDay: repeat_day
        )
        try await EventManger.shared.insertEvent(event: event)
        allEvents.append(event)
    }
    
    func fetchAllEvents(for uid: String) async throws {
        self.allEvents = try await EventManger.shared.fetchEvent(for: uid)
    }
    
    func deleteEvent(title: String, for uid: String) async throws {
        try await EventManger.shared.deleteEvent(title: title, for: uid)
    }
}
