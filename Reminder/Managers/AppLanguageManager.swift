import Foundation
import SwiftUI
import Observation

@Observable
class AppLanguageManager {
    @ObservationIgnored
    @AppStorage("language") private var _language: AppLanguage = .vi
    
    var language: AppLanguage {
        get {
            access(keyPath: \.language)
            return _language
        }
        set {
            withMutation(keyPath: \.language) {
                _language = newValue
            }
        }
    }
}
