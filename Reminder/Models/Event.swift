import Foundation

struct Event: Codable, Identifiable {
    let id: UUID?
    let userID: String
    var title: String
    var eventDateString: String
    var eventType: String
    var repeatDay: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_uid"
        case title
        case eventDateString = "event_date"
        case eventType = "event_type"
        case repeatDay = "repeat_day"
    }
    
    var eventDate: Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: eventDateString) ?? Date()
    }
}
