import Foundation
import SwiftUI

@Observable
class DateSelectionViewModel {
    var selectedDate: Date = Date()
    var selectedOffset: Int = 0

    func updateSelectedDate(offset: Int) {
        selectedOffset = offset
        selectedDate = Calendar.current.date(byAdding: .day, value: offset, to: Date()) ?? Date()
    }

    var isToday: Bool {
        selectedOffset == 0
    }

    var scheduleType: LocalizedStringKey {
        if selectedOffset == 0 {
            return "today_schedule"
        } else if selectedOffset < 0 {
            return "previous_schedule"
        } else {
            return "intended_schedule"
        }
    }
    
    var day: Int {
        Calendar.current.component(.day, from: selectedDate)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: selectedDate)
    }
    
    var year: Int {
        Calendar.current.component(.year, from: selectedDate)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: selectedDate)
    }
}
