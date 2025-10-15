import SwiftUI

struct ScheduleView: View {
    let appUser: AppUser
    let selectedDay: String
    @State private var viewModel = ScheduleViewModel()
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(.systemGroupedBackground),
                        Color(.systemGray6).opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if viewModel.scheduleView.isEmpty {
                    Text("no_schedule_added")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                } else {
                    List {
                        ForEach(Array(viewModel.scheduleView.enumerated()), id: \.element.time) { index, schedule in
                            ScheduleItemView(schedule: schedule, colorIndex: index, appUser: appUser)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        do{
                            try await viewModel.fetchSchedule(for: appUser.uid, date: selectedDay)
                        } catch{
                            print("Error fetch")
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .task(id: selectedDay) {
            do{
                try await viewModel.fetchSchedule(for: appUser.uid, date: selectedDay)
            } catch{
                print("Error fetch")
            }
        }
    }
}

#Preview {
    ScheduleView(appUser: AppUser(uid: "2311", email: "atdevv@gmail.com"), selectedDay: "23/11/2005")
}

