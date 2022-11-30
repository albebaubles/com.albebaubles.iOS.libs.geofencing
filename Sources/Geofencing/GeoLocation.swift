//
//  File.swift
//  
//
//  Created by Alan.Corbett on 11/30/22.
//

import Foundation
import CoreLocation
import SwiftUI

class GeoLocation: NSObject, ObservableObject {
//	let predictionMgr = GeoLocationPredictions()
	@Published var manager: CLLocationManager

	override init() {
		manager = CLLocationManager()
	}

//	func startLocationUpdates() {
//		predictionMgr.startLocationUpdates(with: manager) { location in
////			self.userTrueLocation = location
////			self.locationDidUpdate?(location)
////			self.checkForPacketVisits()
//				// So in here you could check for geofence entry or what have you
//				// . . .
//		}
//	}
//
//	func stopLocationUpdates() {
//		predictionMgr.stopLocationUpdates()
//	}
}

