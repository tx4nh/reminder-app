import SwiftUI

struct ScheduleView: View {
    let appUser: AppUser
    @State private var viewModel = ScheduleViewModel()
    
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
                    Text("Chưa có lịch trình nào được thêm")
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
                        do {
                            try await viewModel.fetchSchedule(for: appUser.uid)
                        } catch {
                            print("DEBUG: Failed to refresh schedule: \(error)")
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .task {
            do{
                try await viewModel.fetchSchedule(for: appUser.uid)
            } catch{
                print("Error fetch")
            }
        }
    }
}

#Preview {
    ScheduleView(appUser: AppUser(uid: "2311", email: "atdevv@gmail.com"))
}

