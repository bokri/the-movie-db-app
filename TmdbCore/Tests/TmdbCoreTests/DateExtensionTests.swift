import XCTest
@testable import TmdbCore

final class DateExtensionTests: XCTestCase {
    func testDateFormatting() {
        // Given
        let dateString = "2023-10-31"
        let expectedFormattedString = "October 2023"
        
        // When
        let formattedString = dateString.formatDateString()
        
        // Then
        XCTAssertEqual(formattedString, expectedFormattedString)
    }
}

