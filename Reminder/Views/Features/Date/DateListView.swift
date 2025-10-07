import SwiftUI

struct DateListView: View {
    @State private var selectedIndex: Int = 0
    @State private var isToday: Int = 0
    
    private var isText: LocalizedStringKey{
        if isToday == 0 {
            return LocalizedStringKey("today_schedule")
        } else if isToday < 0 {
            return LocalizedStringKey("previous_schedule")
        } else {
            return LocalizedStringKey("intended_schedule")
        }
    }

    var body: some View {
        VStack{
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
                    
                    Text(isText)
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
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(-20...20, id: \.self) { index in
                            DateView(
                                day: Calendar.current.component(.day, from: Date()) + index,
                                isSelected: index == selectedIndex
                            )
                            .padding(.vertical, 2)
                            .padding(.horizontal, 5)
                            .animation(.easeInOut(duration: 0.2), value: selectedIndex)
                            .onTapGesture {
                                selectedIndex = index
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    proxy.scrollTo(index, anchor: .center)
                                }
                                isToday = index
                            }
                            .id(index)
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            proxy.scrollTo(selectedIndex, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DateListView()
        .environment(AppLanguageManager())
}
