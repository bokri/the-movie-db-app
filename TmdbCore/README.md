# TmdbCore

TmdbCore is a Swift package for core functionality used in TheMovieDBApp. It provides essential features and utilities for interacting with The Movie Database (TMDb) API.

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg?style=flat)](https://swift.org)
[![License](https://img.shields.io/github/license/abokri/the-movie-db-app)](LICENSE.md)

## Features

- **Networking**: TmdbCore handles HTTP requests and responses to interact with TMDb API endpoints. It includes functions for fetching movies, details, and more.

- **Caching**: The package integrates with Kingfisher for efficient image caching and loading, making it easy to display movie posters and images.

- **Unit Testing**: TmdbCore includes unit tests that ensure the package's functionality is robust and reliable. It uses OHHTTPStubs for API request stubbing during testing.

## Requirements

- Swift 5.9
- iOS 17 or later

## Unit Tests

TmdbCore includes a set of unit tests to ensure that the core functionality is working as expected. You can run these tests in your Xcode project to verify the package's reliability.

## License

TmdbCore is released under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.
