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
                .foregroundColor(.red)
            
            Text("Oops, an error occurred.")
                .font(.title)
                .foregroundColor(.red)
            
            Text("Please try again later.")
                .foregroundColor(.red)
            
            Button(action: {
                Task {
                    do {
                        try await retryAction()
                    } catch {
                        Logger.error("Retry action failed with \(error.localizedDescription)")
                    }
                }
            }) {
                Text("Retry")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ErrorScreen() {
    }
}
