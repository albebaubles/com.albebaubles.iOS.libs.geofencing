import Foundation

@available(iOS 15, macOS 13, *)
public struct GeoFencing {
    public private(set) var id = "com.prepass.mobile.ios.libs.geofencing"

    public init() {
    }

		/// determine estimated time of arrival
		/// - Parameters:
		///   - distance: the distance to the destination
		///   - speed: the speed of travel
		/// - Returns: a double indicating the estimated time orf arrival
	 func eta(distance: Double, speed: Double) -> Double {
		return distance / speed
	}
}
