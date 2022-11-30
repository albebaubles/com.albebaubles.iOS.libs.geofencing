import Foundation

public struct Geofencing {
    public private(set) var id = "com.prepass.mobile.ios.libs.geofencing"

    public init() {
    }

	 func eta(distance: Double, speed: Double) -> Double {
		return distance / speed
	}

	 func formattedEta(distance: Double, speed: Double) -> String {
			// distance / speed == Time To Waypoint
		if distance > 0 && speed > 0 {
			let totalSeconds = (distance / speed).truncatingRemainder(dividingBy: 3600)
			let hours = Int(totalSeconds / 3600)
			let minutes = Int(totalSeconds / 60)
			let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
			return "ETA \(hours):\(minutes):\(seconds)"
		}
		return "ETA unknown"
	}
}
