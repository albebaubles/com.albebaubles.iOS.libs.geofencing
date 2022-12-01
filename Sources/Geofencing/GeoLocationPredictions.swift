	//
	//  GeoLocationPredictions.swift
	//  Fencing
	//
	//  Created by jayson.coppo on 11/15/22.
	//

import Foundation
import CoreLocation

@available(iOS 15, macOS 13, *)
class GeoLocationPredictions {
	private let updateFrequency: Double = 0.1 // seconds

	private var updateLocationTimer: Timer?

		/// Time of last GPS update. This must be manually updated by CLLocationManager
	var timeOfGPSUpdate: Date?

	func startLocationUpdates(
		with locationManager: CLLocationManager,
		updateCallback: @escaping ((CLLocationCoordinate2D) -> Void)
	) {
		updateLocationTimer = Timer.scheduledTimer(
			withTimeInterval: updateFrequency,
			repeats: true,
			block: { _ in
				if let location = locationManager.location,
				   let newLocation = self.calulateTrueLocation(from: location) {
					updateCallback(newLocation)
				}
			}
		)
	}

	func stopLocationUpdates() {
		updateLocationTimer?.invalidate()
	}

	func calulateTrueLocation(from location: CLLocation) -> CLLocationCoordinate2D? {
		guard let timeOfGPSUpdate = timeOfGPSUpdate else {
			print("Failed to calculate distance")
			return nil
		}

			// find the time since the last GPS update
		let timeSinceLastGPSUpdate = Date().timeIntervalSince(timeOfGPSUpdate)


			// calulate distance travelled using speed and time
		let distance = location.speed.magnitude * timeSinceLastGPSUpdate

			// find your current position given your last GPS position and the distance and direction travelled
		return findEndPointFrom(
			startPoint: location.coordinate,
			distance: distance,
			direction: location.course
		)
	}

		/// Finds a geo coordinate given a starting coordinate, distance and direction angle.
		/// - Parameters:
		///   - startPoint: the starting geo location coordinate
		///   - distance: the distance in meters from the starting point
		///   - direction: the course travelled from the starting point in degrees, 0 is due north
		/// - Returns: the end point coordinate
		/// This was converted to Swift from:
		/// https://stackoverflow.com/questions/63476695/how-to-calculate-endpoint-using-initial-point-distance-and-azimuth
	func findEndPointFrom(
		startPoint: CLLocationCoordinate2D,
		distance: Double,
		direction: Double
	) -> CLLocationCoordinate2D {
		let startLat = startPoint.latitude.degreesToRadians()
		let startLong = startPoint.longitude.degreesToRadians()
		let distanceKm = distance / 1000
		let directionRad = direction.degreesToRadians()
		let R_CONST: Double = 6371

		let endLat = asin(
			sin(startLat) * cos(distanceKm/R_CONST) +
			cos(startLat) * sin(distanceKm/R_CONST) * cos(directionRad)
		)

		let endLong = startLong + atan2(
			sin(directionRad) * sin(distanceKm/R_CONST) * cos(startLat),
			cos(distanceKm/R_CONST) - sin(startLat) * sin(endLat)
		)

		return CLLocationCoordinate2D(
			latitude: endLat.radiansToDegrees(),
			longitude: endLong.radiansToDegrees()
		)
	}
}

extension Double {
	func degreesToRadians() -> Double {
		self * Double.pi / 180
	}

	func radiansToDegrees() -> Double {
		self * 180 / Double.pi
	}
}
