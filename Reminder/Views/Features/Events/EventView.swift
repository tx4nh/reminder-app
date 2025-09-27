import SwiftUI

struct EventView: View {
    @State private var selectedDate = Date()
    @State private var showingYearlyEventForm = false
    @State private var showingWeeklyEventForm = false
    @State private var showPopover = false

    @State private var yearlyEvents: [YearlyEvent] = []
    @State private var weeklyEvents: [WeeklyEvent] = []

    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(yearlyEvents) { event in
                        HStack {
                            Text(event.title)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Text(event.formattedDate)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteYearlyEvent)
                    
                    Button(action: {
                        showingYearlyEventForm = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                            Text("add_event")
                                .foregroundColor(.blue)
                        }
                    }
                } header: {
                    Text("event_every_year")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                Section {
                    ForEach(weeklyEvents) { event in
                        HStack {
                            Text(event.title)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Text(event.formattedDayOfWeek)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteWeeklyEvent)
                    
                    Button(action: {
                        showingWeeklyEventForm = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                            Text("add_event")
                                .foregroundColor(.blue)
                        }
                    }
                } header: {
                    Text("event_every_week")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .navigationTitle("event_text")
            .navigationBarTitleDisplayMode(.automatic)
            .sheet(isPresented: $showingYearlyEventForm) {
                AddYearlyEventView(events: $yearlyEvents)
            }
            .sheet(isPresented: $showingWeeklyEventForm) {
                AddWeeklyEventView(events: $weeklyEvents)
            }
        }
    }

    private func deleteYearlyEvent(at offsets: IndexSet) {
        yearlyEvents.remove(atOffsets: offsets)
    }

    private func deleteWeeklyEvent(at offsets: IndexSet) {
        weeklyEvents.remove(atOffsets: offsets)
    }
}

#Preview {
    EventView()
}
