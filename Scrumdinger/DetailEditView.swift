import Foundation
import SwiftUI

struct DetailEditView: View {
    @State private var data = DailyScrum.Data()
    @State private var newAttendee = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1){
                        Text("Length")
                    }
                    .accessibilityValue("\(data.lengthInMinutes) minutes")
                    
                    Spacer()
                    
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indexSet in
                    data.attendees.remove(atOffsets: indexSet)
                }
                
                HStack {
                    TextField("New Attendee", text: $newAttendee)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendee)

                            data.attendees.append(attendee)
                            newAttendee = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendee.isEmpty)
                }
            }
        }
    }
}

struct EditDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
