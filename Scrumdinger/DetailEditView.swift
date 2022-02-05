import Foundation
import SwiftUI

struct EditDetailView: View {
    @State private var data = DailyScrum.Data()
    
    var body: some View {
        Form {
            Section("Meeting Info"){
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1){
                        Text("Length")
                    }
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                }
            }
        }
    }
}

struct EditDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditDetailView()
    }
}
