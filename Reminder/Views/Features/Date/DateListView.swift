import SwiftUI

struct DateListView: View {
    @State private var focusedItemIndex: Int? = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(-20...20, id: \.self) { index in
                        DateView(day: Calendar.current.component(.day, from: Date()) + index)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 10)
                            .animation(.easeInOut(duration: 0.2), value: focusedItemIndex)
                            .onTapGesture {
                                focusedItemIndex = index
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    proxy.scrollTo(index, anchor: .center)
                                }
                            }
                            .id(index)
                    }
                }
                .padding(.horizontal, 20)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let initialIndex = focusedItemIndex {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            proxy.scrollTo(initialIndex, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DateListView()
}
