import XCTest
@testable import Geofencing

final class GeofencingTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Geofencing().id, "com.prepass.mobile.ios.libs.geofencing")
    }

	func testETA() throws {
		XCTAssertTrue(Geofencing().eta(distance: 120, speed: 60) == 2.0)
	}


}
