# TheMovieDBApp

Welcome to TheMovieDBApp, an amazing application for all your movie information needs! It's designed with ❤️ and brings the latest in movie information right to your fingertips. This app also features a local database created with SwiftData for a seamless offline experience.

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg?style=flat)](https://swift.org)
[![License](https://img.shields.io/github/license/bokri/the-moviedb-app)](LICENSE.md)

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Screenshots](#screenshots)
- [Unit Tests](#unit-tests)
- [Dependencies](#dependencies)
- [License](#license)

## Getting Started

### Prerequisites

Before you get started, ensure you have the following tools and dependencies installed:

- [XcodeGen](https://github.com/yonaskolb/XcodeGen) - Used for generating the Xcode project file.

### Installation

To set up the project, follow these steps:

1. Clone this repository:

   ```sh
   git clone https://github.com/your-username/the-moviedb-app.git
   ```

2. Navigate to the project directory:

   ```sh
   cd the-moviedb-app
   ```

3. Generate the Xcode project using XcodeGen:

   ```sh
   xcodegen generate
   ```

Now you have your Xcode project ready for development!


## Screenshots

![Screenshot 1](screenshots/screenshot-1.png)
![Screenshot 2](screenshots/screenshot-2.png)
![Screenshot 3](screenshots/screenshot-3.png)
![Screenshot 4](screenshots/screenshot-4.png)

## Unit Tests

We have a suite of unit tests that cover various aspects of the application. These tests ensure that the application functions correctly and help maintain its quality. The unit tests for this project are implemented in the Swift Package Manager (SPM) TmdbCore. We use [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) for API stubbing during unit testing.

Please refer to the TmdbCore package for details on running and configuring the unit tests.

## Dependencies

TheMovieDBApp uses the following dependencies:

- [Kingfisher](https://github.com/onevcat/Kingfisher) for efficient image caching and loading.
- [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) for API request stubbing during unit testing.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.


---

_© 2023 TheMovieDBApp_