//
//  ErrorScreen.swift
//
//  Created by Aymen Bokri on 30/10/2023.
//

import SwiftUI

/// A view to display an error message and provide a retry action.
public struct ErrorScreen: View {
    
    // MARK: - Properties
    
    /// The retry action to be performed when the retry button is tapped.
    let retryAction: () async throws -> Void
    
    // MARK: - Constructors
    
    /// Initializes a new instance of `ErrorScreen`.
    /// - Parameter retryAction: The retry action to be performed when the retry button is tapped.
    public init(retryAction: @escaping () async throws -> Void) {
        self.retryAction = retryAction
    }
    
    // MARK: - SwiftUI
    
    public var body: some View {
        VStack {
            Spacer()
            
            // Error Icon
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 100))
                .foregroundColor(Color(.errorRed))
                .padding()
            
            // Error Title
            Text(String(localized: "error.title", bundle: Bundle.module))
                .font(.title)
                .foregroundColor(Color(.errorRed))
                
            // Error Subtitle
            Text(String(localized: "error.subtitle", bundle: Bundle.module))
                .foregroundColor(Color(.errorRed)) // Use a custom color
            
            // Retry Button
            Button(action: {
                Task {
                    do {
                        try await retryAction()
                    } catch {
                        Logger.error("Retry action failed with \(error.localizedDescription)")
                    }
                }
            }) {
                Text(String(localized: "error.cta", bundle: Bundle.module))
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.errorRed))
                    .cornerRadius(10)
            }.padding()
            
            Spacer()
        }
        .padding()
    }

}

// Preview the ErrorScreen view
#Preview {
    ErrorScreen() {
    }
}
