import SwiftUI

@main
struct ReminderApp: App {
    @State private var themeViewModel = ThemeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ReminderAppView()
                .environment(themeViewModel)
                .preferredColorScheme(themeViewModel.isDarkMode ? .dark : .light)
        }
    }
}
