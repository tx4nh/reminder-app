import Foundation
import Swift

@Observable
class EventViewModel{
    var eventView: [Event] = []
    
    func insertEvent(user_uid: String, title: String, event_date: Date, event_type: String) async throws {
        let event = Event(
            id: nil,
            userID: user_uid,
            title: title,
            eventDateString: ISO8601DateFormatter().string(from: event_date),
            eventType: event_type,
            repeatDay: nil
        )
        try await EventManger.shared.insertEvent(event: event)
        eventView.append(event)
    }
    
    func fetchEvent(for uid: String) async throws {
        let event: [Event] = try await EventManger.shared.fetchEvent(for: uid)
        self.eventView = event
    }
    
    func deleteEvent(title: String, for uid: String) async throws {
        try await EventManger.shared.deleteEvent(title: title, for: uid)
    }
}
