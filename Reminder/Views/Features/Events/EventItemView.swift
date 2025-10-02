import SwiftUI

struct EventItemView: View {
    let appUser: AppUser
    let event: Event
    let date = Date()
    var type: Int
    @State private var selectedDate = Date()
    @State private var eventViewModel = EventViewModel()
    @State private var showDeleteAlert: Bool = false
    
    private let weekdayNames = [
        1: "Chủ nhật",
        2: "Thứ 2",
        3: "Thứ 3",
        4: "Thứ 4",
        5: "Thứ 5",
        6: "Thứ 6",
        7: "Thứ 7"
    ]

    var body: some View {
        HStack {
            Text(event.title)
                .font(.system(size: 16, weight: .medium))
            
            Spacer()
            
            if type == 1 {
                Text(event.eventDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                Text(weekdayNames[event.repeatDay ?? 1] ?? "Thứ 2")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
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
                        try await eventViewModel.deleteEvent(title: event.title, for: appUser.uid)
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
    EventItemView(
        appUser: .init(
            uid: "2311",
            email: "atdevv@gmail.com"
        ),
        event: Event(
            id: nil,
            userID: "23112005",
            title: "Dinh Tuan Anh",
            eventDateString: "23/11/2005",
            eventType: "yearly",
            repeatDay: nil
        ),
        type: 2
    )
}
