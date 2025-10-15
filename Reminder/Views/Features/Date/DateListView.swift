import SwiftUI

struct DateListView: View {
    let appUser: AppUser
    @State private var dateManager = DateSelectionViewModel()
    @Environment(AppLanguageManager.self) var appLanguage

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    Image(systemName: "calendar")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text(dateManager.scheduleType)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.primary, .secondary],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
                
                Text("Ngày đã chọn: \(dateManager.formattedDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(-20...20, id: \.self) { offset in
                            DateView(
                                offset: offset,
                                isSelected: offset == dateManager.selectedOffset,
                                baseDate: Date()
                            )
                            .padding(.vertical, 2)
                            .padding(.horizontal, 5)
                            .animation(.easeInOut(duration: 0.2), value: dateManager.selectedOffset)
                            .onTapGesture {
                                dateManager.updateSelectedDate(offset: offset)
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    proxy.scrollTo(offset, anchor: .center)
                                }
                                print("Full date: \(dateManager.formattedDate)")
                            }
                            .id(offset)
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            proxy.scrollTo(dateManager.selectedOffset, anchor: .center)
                        }
                    }
                }
            }
            
            ScheduleView(appUser: appUser, selectedDay: dateManager.formattedDate)
        }
        .environment(dateManager)
    }
}

#Preview {
    DateListView(appUser: .init(uid: "2311", email: "")).environment(AppLanguageManager())
}
