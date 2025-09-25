import Foundation

struct WeeklyEvent: Identifiable, Codable {
    let id: Int
    let title: String
    let dayOfWeek: Int // 1 = Sunday, 2 = Monday, etc.
    
    var formattedDayOfWeek: String {
        let dayNames = ["", "Chủ Nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"]
        return dayNames[dayOfWeek]
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, dayOfWeek
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        dayOfWeek = try container.decode(Int.self, forKey: .dayOfWeek)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(dayOfWeek, forKey: .dayOfWeek)
    }
    
    init(id: Int, title: String, dayOfWeek: Int) {
        self.id = id
        self.title = title
        self.dayOfWeek = dayOfWeek
    }
}
