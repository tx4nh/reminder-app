import SwiftUI

struct AddScheduleView: View {
    let appUser: AppUser
    @State private var selectedDate = Date()
    @State private var text: String = ""
    @State private var scheduleViewModel = ScheduleViewModel()
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 24) {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar.badge.plus")
                                .font(.system(size: 48))
                                .foregroundColor(.blue)
                            
                            Text("add_new_schedule")
                                .textInputAutocapitalization(.words)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "text.document")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                    Text("job_content")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    TextField("enter_to_day_to_do_list", text: $text, axis: .vertical)
                                        .focused($isTextFieldFocused)
                                        .frame(minHeight: 100, alignment: .topLeading)
                                        .textFieldStyle(PlainTextFieldStyle())
                                        .font(.body)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                        .background(Color(.systemBackground))
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(text.isEmpty ? Color.gray.opacity(0.3) : Color.blue.opacity(0.5), lineWidth: 1)
                                        )
                                    
                                    Text("des_detail_job")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal, 4)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "clock.fill")
                                        .foregroundColor(.orange)
                                        .font(.callout)
                                    Text("notification_time")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                
                                HStack {
                                    DatePicker("",
                                             selection: $selectedDate,
                                             displayedComponents: .hourAndMinute)
                                        .datePickerStyle(CompactDatePickerStyle())
                                        .labelsHidden()
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing) {
                                        Text("selected_time")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(selectedDate.formatTime())
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.orange)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                                )
                                
                                HStack {
                                    DatePicker("Chọn ngày",
                                             selection: $selectedDate,
                                               displayedComponents: .date)
                                        .datePickerStyle(CompactDatePickerStyle())
                                        .labelsHidden()
                                        .environment(\.locale, Locale(identifier: "en"))
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing) {
                                        Text("Ngày được chọn")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(selectedDate.toDateString())
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.orange)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 50)
                        
                        VStack(spacing: 12) {
                            Button(action: {
                                isTextFieldFocused = false
                                addSchedule()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("add_schedule")
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(
                                    LinearGradient(
                                        colors: [Color.blue, Color.blue.opacity(0.8)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(12)
                            }
                            .disabled(text.isEmpty)
                            .opacity(text.isEmpty ? 0.6 : 1.0)
                            
                            Button("cancel_text") {
                                isTextFieldFocused = false
                                presentationMode.wrappedValue.dismiss()
                            }
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 44)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                    .frame(minHeight: geometry.size.height)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
            .contentShape(Rectangle())
            .onTapGesture {
                isTextFieldFocused = false
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("done_text") {
                        isTextFieldFocused = false
                    }
                }
            }
        }
    }
    
    private func addSchedule() {
        let newSchedule = Schedule(
            user_uid: appUser.uid,
            text: text,
            time: selectedDate.toTimeString(),
            date: selectedDate.toDateString()
        )
        
        Task {
            do {
                try await scheduleViewModel.insertSchedule(schedule: newSchedule)
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    AddScheduleView(appUser: .init(uid: "123", email: "keke@gmail.com"))
}
