import SwiftUI

struct EventItemView: View {
    let appUser: AppUser
    let event: Event
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
                Text(formattedDate)
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
            Button("delete_text", role: .destructive) { }
        } message: {
            Text("are_you_sure_delete")
        }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: event.eventDate)
    }
}

#Preview {
    EventItemView(appUser: .init(uid: "2311", email: "atdevv@gmail.com"), event: Event(id: nil, userID: "23112005", title: "Dinh Tuan Anh", eventDate: Date(), eventType: "yearly", repeatDay: nil), type: 1)
}
