import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case en, vi
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
            case .vi: return "Tiếng Việt"
            case .en: return "English"
        }
    }
}
