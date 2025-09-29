import Foundation
import SwiftUI

struct AddYearlyEventView: View {
    let appUser: AppUser
    @Environment(\.dismiss) private var dismiss
    @State private var eventViewModel = EventViewModel()
    @State private var title = ""
    @State private var selectedDate = Date()

    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.secondary.opacity(0.3))
                .frame(width: 36, height: 4)
                .padding(.top, 8)
            
            VStack(spacing: 16) {
                Text("add_events_every_year")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("event_name")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    TextField("enter_event_name", text: $title)
                        .autocorrectionDisabled()
                        .frame(height: 40)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        .font(.system(size: 16))
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("day_notifica")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(formattedDate)
                            .font(.system(size: 16))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .labelsHidden()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()

            HStack(spacing: 12) {
                Button("cancel_text") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.regularMaterial)
                .cornerRadius(8)
                
                Button("save_text") {
                    if !title.trimmingCharacters(in: .whitespaces).isEmpty {
                            addEvent()
                            dismiss()
                       }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                .opacity(title.trimmingCharacters(in: .whitespaces).isEmpty ? 0.6 : 1)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .presentationDetents([.height(370)])
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: selectedDate)
    }

    private func extractDayMonth() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .month, .year], from: selectedDate)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(from: components) ?? selectedDate
    }
    
    private func addEvent() {
        Task{
            do{
                try await eventViewModel
                    .insertEvent(
                        user_uid: appUser.uid,
                        title: title,
                        event_date: extractDayMonth(),
                        event_type: "yearly"
                    )
            } catch{
                print(
                    "Error with add event"
                )
                print(error.localizedDescription)
            }
        }
    }
}

#Preview{
    AddYearlyEventView(appUser: .init(uid: "2311", email: "atdevv@gmail.com"))
}
