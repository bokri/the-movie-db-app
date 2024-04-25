//
//  PosterImageView.swift
//  TheMovieDBApp
//
//  Created by Aymen Bokri on 29/10/2023.
//

import SwiftUI
import NukeUI

/**
 A SwiftUI view for displaying an image from a given URL with Kingfisher integration.

 The `PosterImageView` is a SwiftUI view designed for displaying images fetched from a remote URL using the Kingfisher library. It supports loading indicators, resizable images, and customizable placeholders for smooth image rendering.

 - Note: This view uses the Kingfisher library for image loading and caching. Make sure to add Kingfisher to your project for proper functionality.

 # Parameters:
 - `imageURL`: The URL of the image to be displayed.
 - `width`: The optional maximum width of the image view. If not provided, it defaults to the maximum available width.
 - `height`: The height of the image view.

 # See Also:
 - `LazyImage`: NukeUI's SwiftUI view for image loading.
 - `ProgressView`: A SwiftUI view for showing loading progress.
 - `Logger`: A logging utility for handling errors or issues.

 For more information on using Kingfisher with SwiftUI and customization options, refer to the Kingfisher documentation.

 */
public struct PosterImageView: View {
    
    // MARK: - Properties

    let imageURL: String
    let width: CGFloat?
    let height: CGFloat
    
    // MARK: - Constructors
    
    /**
     Initializes a `PosterImageView` with the specified parameters.
     
     - Parameters:
     - imageURL: The URL of the image to be displayed.
     - width: The optional maximum width of the image view. If not provided, it defaults to the maximum available width.
     - height: The height of the image view.
     */
    public init(imageURL: String, width: CGFloat? = nil, height: CGFloat) {
        self.imageURL = imageURL
        self.width = width
        self.height = height
    }
    
    // MARK: - SwiftUI
    
    public var body: some View {
        LazyImage(request: ImageRequest(url: URL(string: imageURL), processors: [.resize(height: height)]))
            .onCompletion({ result in
                switch result {
                case .failure(let error):
                    Logger.warning("Image download failed with error: \(error)")
                default:
                    break
                }
            })
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: width ?? .infinity, maxHeight: height)
            .cornerRadius(10)
    }
}

#Preview {
    let imageUrl = Constants.imagesBaseUrl + "/xi8Iu6qyTfyZVDVy60raIOYJJmk.jpg"
    return PosterImageView(imageURL: imageUrl, width: 80, height: 120)
}
