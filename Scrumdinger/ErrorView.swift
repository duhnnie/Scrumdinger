import Foundation
import SwiftUI

struct ErrorView: View {
    var errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleErrors: Error {
        case SomeError
    }

    static let errorWrapper = ErrorWrapper(error: SampleErrors.SomeError, guidance: "This error can be safely ignored")

    static var previews: some View {
        ErrorView(errorWrapper: errorWrapper)
    }
}
