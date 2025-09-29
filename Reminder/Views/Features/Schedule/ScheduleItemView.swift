import SwiftUI

struct ScheduleItemView: View {
    let schedule: Schedule
    let colorIndex: Int
    let appUser: AppUser
    var index = 0
    @State private var scheduleViewModel = ScheduleViewModel()
    @State private var showDeleteAlert: Bool = false

    private let arrColors: [Color] = [
        .red, .blue, .green, .orange, .purple, .pink,
        .yellow, .cyan, .mint, .indigo, .brown, .teal
    ]
    
    private var timeColor: Color {
        let index = colorIndex % arrColors.count
        return arrColors[index]
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Text(schedule.displayTime)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(timeColor)
            }
            .frame(width: 80)
            
            Rectangle()
                .fill(timeColor.opacity(0.3))
                .frame(width: 2, height: 50)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(schedule.text.capitalized)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Circle()
                    .fill(timeColor.opacity(0.2))
                    .frame(width: 12, height: 12)
                    .overlay(
                        Circle()
                            .stroke(timeColor, lineWidth: 2)
                    )
            }
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(timeColor.opacity(0.5), lineWidth: 1)
        )
        .swipeActions(edge: .trailing) {
            Button{
                showDeleteAlert.toggle()
            } label: {
                Text("delete_text")
                Image(systemName: "trash")
            }
            .tint(.red)
            
            Button{
                
            } label: {
                Text("modify_text")
                Image(systemName: "pencil.line")
            }
            .tint(.blue)
        }
        .alert("confirm_delete", isPresented: $showDeleteAlert){
            Button("cancel_text", role: .cancel) { }
            Button("delete_text", role: .destructive) {
                Task{
                    do{
                        try await scheduleViewModel.deleteSchedule(text: schedule.text, for: appUser.uid)
                    } catch {
                        print("Error Delete")
                    }
                }
            }
        } message: {
            Text("are_you_sure_delete")
        }
    }
}

#Preview {
    ScheduleItemView(schedule: Schedule(user_uid: "2311", text: "Game", time: "12:00"), colorIndex: 0, appUser: AppUser(uid: "2311", email: "atd@gmail.com"))
}
