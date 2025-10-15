# Reminder App

A SwiftUI-based reminder application with schedule management, user authentication, and multi-language support.

## Features

- **User Authentication**: Sign up and sign in functionality using Supabase
- **Schedule Management**: Create, view, and delete personal schedules
- **Multi-language Support**: Localization with multiple language options
- **Dark/Light Mode**: Theme switching capability
- **Notifications**: Local notification support for reminders
- **Events**: Weekly and yearly event management
- **Modern UI**: SwiftUI with gradient designs and smooth animations

## Architecture Structure

```
Reminder/
│
├── Managers/
│   ├── AppLanguageManager
│   ├── AuthManager
│   ├── EventManager
│   ├── NotificationManager
│   ├── ScheduleOneDayManager
│   └── SoundManager
│
├── Models/
│   ├── AppUser
│   ├── Event
│   ├── Language
│   ├── Schedule
│   └── Sound
│
├── Sounds/
│
├── ViewModels/
│   ├── DateSelectionViewModel
│   ├── EventViewModel
│   ├── ScheduleViewModel
│   ├── SignInViewModel
│   ├── ThemeViewModel
│   └── UserNameViewModel
│
├── Views/
│   ├── Components/
│   │   ├── ButtonLoadData
│   │   ├── CustomTextFieldView
│   │   ├── InfoRowView
│   │   ├── PickerRowView
│   │   ├── SecureFieldView
│   │   ├── SettingRowView
│   │   ├── SoundPickerView
│   │   ├── TextFieldView
│   │   ├── TimeNotification
│   │   ├── TimePickerView
│   │   └── ToggleRowView
│   │
│   ├── Features/
│   │   ├── Authentication/
│   │   │   ├── LoadingView
│   │   │   ├── RegisterView
│   │   │   └── SignInView
│   │   │
│   │   ├── Date/
│   │   │   ├── DateListView
│   │   │   └── DateView
│   │   │
│   │   ├── Events/
│   │   │   ├── AddWeeklyEventView
│   │   │   ├── AddYearlyEventView
│   │   │   ├── EventItemView
│   │   │   └── EventView
│   │   │
│   │   ├── Schedule/
│   │   │   ├── AddScheduleView
│   │   │   ├── ScheduleItemView
│   │   │   └── ScheduleView
│   │   │
│   │   └── Settings/
│   │       ├── AboutView
│   │       ├── ChangePasswordView
│   │       ├── LanguageSettingView
│   │       ├── NotificationBannerView
│   │       ├── NotificationSettingsView
│   │       ├── ProfileSettingsView
│   │       └── SettingView
│   │
│   └── Main/
│       ├── MainTabView
│       ├── MainView
│       └── ReminderAppView
│
└── Assets/
├── Localizable
├── Supabase(api_here)
└── ReminderApp

```
