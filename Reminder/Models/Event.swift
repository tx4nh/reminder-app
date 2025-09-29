import Foundation

struct Event: Codable, Identifiable {
    let id: UUID?
    let userID: String
    var title: String
    var eventDate: Date
    var eventType: String
    var repeatDay: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case eventDate = "event_date"
        case eventType = "event_type"
        case repeatDay = "repeat_day"
   }
}
