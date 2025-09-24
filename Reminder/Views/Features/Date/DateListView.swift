import SwiftUI

struct DateListView: View {
    @State private var selectedIndex: Int = 0

    var body: some View {
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

#Preview {
    DateListView()
        .environment(AppLanguageManager())
}
