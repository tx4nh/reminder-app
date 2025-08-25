import SwiftUI

struct ScheduleView: View {
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
//                        VStack {
//                            Text("My Daily Schedule")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//                                .foregroundColor(.primary)
//                            
//                            Text("Today's Tasks")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        .padding(.top, 20)
//                        .padding(.bottom, 10)
                        
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
                Text(schedule.time)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(timeColor)
//                
//                Circle()
//                    .fill(timeColor)
//                    .frame(width: 8, height: 8)
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
                    
                    Text("Scheduled task")
                        .font(.caption)
                        .foregroundColor(.secondary)
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
    ScheduleView()
}
