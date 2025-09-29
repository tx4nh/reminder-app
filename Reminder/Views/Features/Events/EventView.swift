import SwiftUI

struct EventView: View {
    let appUser: AppUser
    @State private var selectedDate = Date()
    @State private var showingYearlyEventForm = false
    @State private var showingWeeklyEventForm = false
    @State private var showPopover = false

    @State private var eventModelView = EventViewModel()
    @State private var yearlyEvents: [Event] = []
    @State private var weeklyEvents: [Event] = []

    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(eventModelView.eventView) { event in
                        EventItemView(appUser: appUser, event: event, type: 1)
                    }
                    
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
                    ForEach(eventModelView.eventView) { event in
                        EventItemView(appUser: appUser, event: event, type: 2)
                    }
                    
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
}

#Preview {
    EventView(appUser: AppUser(uid: "2311", email: "atdevv@gmail.com"))
}
