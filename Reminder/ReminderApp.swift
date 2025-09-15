import SwiftUI

@main
struct ReminderApp: App {
    @State private var themeViewModel = ThemeViewModel()
    @State private var appSetting = AppLanguageManager()
    @State private var userName = UserNameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ReminderAppView()
                .environment(themeViewModel)
                .environment(appSetting)
                .environment(userName)
                .preferredColorScheme(themeViewModel.isDarkMode ? .dark : .light)
                .environment(\.locale, Locale(identifier: appSetting.language.id))
        }
    }
}
