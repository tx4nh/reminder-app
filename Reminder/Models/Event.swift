import Foundation

struct Event: Codable {
    let id: UUID?
    let userID: UUID
    let title: String
    let eventDate: Date
    let eventType: String
    let repeatDay: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case eventDate = "event_date"
        case eventType = "event_type"
        case repeatDay = "repeat_day"
   }
}
