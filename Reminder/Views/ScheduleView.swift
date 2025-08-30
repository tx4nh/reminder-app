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
                            ScheduleItemView(schedule: schedule, colorIndex: index)
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

struct ScheduleItemView: View {
    let schedule: Schedule
    let colorIndex: Int
    var index = 0
    @State private var viewModel = ScheduleViewModel()
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
                Text("Xoá")
                Image(systemName: "trash")
            }
            .tint(.red)
            
            Button{
                
            } label: {
                Text("Sửa")
                Image(systemName: "pencil.line")
            }
            .tint(.blue)
        }
        .alert("Xác nhận xoá", isPresented: $showDeleteAlert){
            Button("Hủy", role: .cancel) { }
            Button("Xóa", role: .destructive) {
            }
        } message: {
            Text("Bạn có chắc muốn xoá không?")
        }
    }
}

#Preview {
    ScheduleView(appUser: AppUser(uid: "2311", email: "atdevv@gmail.com"))
}

