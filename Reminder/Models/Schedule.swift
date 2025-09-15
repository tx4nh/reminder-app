import Foundation

struct Schedule: Codable {
    let user_uid: String
    var text: String
    var time: String
    
    var displayTime: String {
        String(time.prefix(5))
    }
}
