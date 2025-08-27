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
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        
                        ForEach(viewModel.test, id: \.text) { schedule in
                            ScheduleItemView(schedule: schedule)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            Task{
                do{
                    try await viewModel.fetchSchedule(for: appUser.uid)
                } catch{
                    print("Error fetch")
                }
            }
        }
    }
}

struct ScheduleItemView: View {
    let schedule: Schedule
    
    private var timeColor: Color {
        switch schedule.time.prefix(2) {
        case "08": return .orange
        case "10": return .green
        case "13": return .blue
        case "17": return .purple
        case "22": return .indigo
        default: return .gray
        }
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
                    color: Color.black.opacity(0.1),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(timeColor.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    ScheduleView(appUser: AppUser(uid: "2311", email: "atdevv@gmail.com"))
}

