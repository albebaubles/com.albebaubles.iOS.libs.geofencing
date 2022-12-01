
import Foundation
import CoreLocation
import SwiftUI

@available(iOS 15, macOS 13, *)
class GeoLocation: CLLocationManager, ObservableObject {

	let predictionMgr = GeoLocationPredictions()

	override init() {
	}

	override func startUpdatingLocation() {
		startLocationPredicting()
		super.startUpdatingLocation()
	}

	override func stopUpdatingLocation() {
		stopUpdatingLocation()
		super.stopUpdatingLocation()
	}

	func startLocationPredicting() {
		predictionMgr.startLocationUpdates(with: self) { location in
				// So in here you could check for geofence entry or what have you
				// . . .
		}
	}

	func stopLocationPredicting() {
		predictionMgr.stopLocationUpdates()
	}
}

@available(iOS 15, macOS 13, *)
extension GeoLocation : CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
#if !os(macOS)
		if status == .authorizedAlways || status == .authorizedWhenInUse {
			startUpdatingLocation()
			startUpdatingHeading()
			startMonitoringSignificantLocationChanges()
		}
#endif
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if locations.first!.horizontalAccuracy > 0 {
			predictionMgr.timeOfGPSUpdate = Date()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
	}
}
