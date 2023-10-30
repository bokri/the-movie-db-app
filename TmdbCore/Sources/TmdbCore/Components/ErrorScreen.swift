//
//  ErrorScreen.swift
//
//
//  Created by Aymen Bokri on 30/10/2023.
//

import SwiftUI

public struct ErrorScreen: View {
    
    let retryAction: () async throws -> Void
    
    public init(retryAction: @escaping () async throws -> Void) {
        self.retryAction = retryAction
    }
    
    public var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 100))
                .foregroundColor(Color(.errorRed))
                .padding()
            
            Text(String(localized: "error.title", bundle: Bundle.module))
                .font(.title)
                .foregroundColor(Color(.errorRed))
                
            
            Text(String(localized: "error.subtitle", bundle: Bundle.module))
                .foregroundColor(Color(.errorRed)) // Use a custom color
            
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

#Preview {
    ErrorScreen() {
    }
}
