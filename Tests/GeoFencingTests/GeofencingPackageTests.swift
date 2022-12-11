import XCTest
@testable import GeoFencing

@available(iOS 15, macOS 13, *)
final class GeoFencingTests: XCTestCase {
    func testID() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GeoFencing().id, "com.prepass.mobile.ios.libs.geofencing")
    }

	func testETA() throws {
		XCTAssertTrue(GeoFencing().eta(distance: 120, speed: 60) == 2.0)
	}
}
