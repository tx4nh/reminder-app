import SwiftUI

@main
struct ReminderApp: App {
    @State private var themeViewModel = ThemeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ReminderAppView()
                .environment(themeViewModel)
                .environment(\.colorScheme, themeViewModel.isDarkMode ? .dark : .light)
        }
    }
}
