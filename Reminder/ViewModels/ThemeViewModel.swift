import Foundation
import SwiftUI
import Observation

@Observable
class ThemeViewModel {
    @ObservationIgnored
    @AppStorage("isDarkMode") private var _isDarkMode: Bool = false
    
    var isDarkMode: Bool {
        get {
            access(keyPath: \.isDarkMode)
            return _isDarkMode
        }
        set {
            withMutation(keyPath: \.isDarkMode) {
                _isDarkMode = newValue
            }
        }
    }
}
