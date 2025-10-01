import Foundation
import SwiftUI

struct AddWeeklyEventView: View {
    let appUser: AppUser
    @Environment(\.dismiss) private var dismiss
    @State private var eventViewModel = EventViewModel()
    @State private var title = ""
    @State private var selectedDayOfWeek = 2

    private let weekDays = [
        "Chủ nhật",
        "Thứ 2",
        "Thứ 3",
        "Thứ 4",
        "Thứ 5",
        "Thứ 6",
        "Thứ 7"
    ]

    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.secondary.opacity(0.3))
                .frame(width: 36, height: 4)
                .padding(.top, 8)
            
            VStack(spacing: 16) {
                Text("add_events_every_week")
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
                    Text("notification_time")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(weekDays[selectedDayOfWeek])
                            .font(.system(size: 16))
                            .foregroundColor(.primary)

                        Spacer()

                        Picker("Ngày trong tuần", selection: $selectedDayOfWeek) {
                            ForEach(weekDays.indices, id: \.self) { index in
                                Text(weekDays[index]).tag(index)
                            }
                        }
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
                    if isTitleValid {
                            addEvent()
                            dismiss()
                       }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(!isTitleValid)
                .opacity(isTitleValid ? 1 : 0.6)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .presentationDetents([.height(370)])
    }
    
    private var isTitleValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private func addEvent() {
        Task{
            do{
                try await eventViewModel
                    .insertEvent(
                        user_uid: appUser.uid,
                        title: title,
                        event_date: Date(),
                        event_type: "weekly",
                        repeat_day: selectedDayOfWeek + 1
                    )
            } catch{
                print("Error with add event: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    AddWeeklyEventView(
        appUser: .init(
            uid: "2311",
            email: "Atdevv@gmail.com"
        ),
    )
}
