import Foundation

class EventViewModel{
    var eventView: [Event] = []
    
    func insertEvent(user_id: String, title: String, event_date: Date, event_type: String) async throws {
        let event = Event(id: nil, userID: user_id, title: title, eventDate: event_date, eventType: event_type, repeatDay: nil)
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
