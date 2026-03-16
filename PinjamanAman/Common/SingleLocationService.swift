//
//  SingleLocationService.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/11.
//

import UIKit
import CoreLocation

final class SingleLocationService: NSObject {
    
    typealias LocationDataCompletion = ([String: String]?) -> Void
    
    // MARK: - Properties
    
//    private lazy var locationManager: CLLocationManager = {
//        let manager = CLLocationManager()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        return manager
//    }()
    
    private var locationManager: CLLocationManager?
    
    private let geocoder = CLGeocoder()
    
    private var completionHandler: LocationDataCompletion?
    
    // MARK: - Public
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestCurrentLocation(completion: @escaping LocationDataCompletion) {
        completionHandler = completion
        checkAuthorizationStatus()
    }
    
    // MARK: - Authorization
    
    private func checkAuthorizationStatus() {
        let status: CLAuthorizationStatus = CLLocationManager().authorizationStatus
       
        handleAuthorization(status)
    }
    
    private func handleAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager?.startUpdatingLocation()
            
        case .restricted, .denied:
            handleError()
            
        @unknown default:
            handleError()
        }
    }
    
    // MARK: - Location Handling
    
    private func processLocation(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Reverse geocode failed: \(error.localizedDescription)")
                self.handleError()
                return
            }
            
            guard let placemark = placemarks?.first else {
                self.handleError()
                return
            }
            
            let latString = String(location.coordinate.latitude)
            
            let longString = String(location.coordinate.longitude)
            
            LocationInfoStorage.save(latitude: latString, longitude: longString)
            
            let infoDict = self.buildLocationDictionary(
                placemark: placemark,
                location: location
            )
            
            self.completionHandler?(infoDict)
            self.stopUpdating()
        }
    }
    
    private func buildLocationDictionary(
        placemark: CLPlacemark,
        location: CLLocation
    ) -> [String: String] {
        
        return [
            "cultural": placemark.administrativeArea ?? "",
            "centuries": placemark.isoCountryCode ?? "",
            "addition": placemark.country ?? "",
            "things": placemark.thoroughfare ?? "",
            "order": String(location.coordinate.latitude),
            "reminder": String(location.coordinate.longitude),
            "decay": placemark.locality ?? "",
            "falling": placemark.subLocality ?? ""
        ]
    }
    
    // MARK: - Error & Stop
    
    private func handleError() {
        completionHandler?(nil)
        stopUpdating()
    }
    
    private func stopUpdating() {
        locationManager?.stopUpdatingLocation()
    }
    
    deinit {
        stopUpdating()
    }
}

// MARK: - CLLocationManagerDelegate

extension SingleLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        processLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError,
           clError.code == .locationUnknown {
            return
        }
        
        handleError()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            
        case .denied, .restricted:
            handleError()
            
        default:
            break
        }
    }
}

class LocationInfoStorage {
    
    private enum Keys {
        static let longitude = "longitude"
        static let latitude = "latitude"
    }
    
    static func save(latitude: String, longitude: String) {
        UserDefaults.standard.set(latitude, forKey: Keys.latitude)
        UserDefaults.standard.set(longitude, forKey: Keys.longitude)
    }
    
    static var storedLongitude: String {
        UserDefaults.standard.string(forKey: Keys.longitude) ?? ""
    }
    
    static var storedLatitude: String {
        UserDefaults.standard.string(forKey: Keys.latitude) ?? ""
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: Keys.latitude)
        UserDefaults.standard.removeObject(forKey: Keys.longitude)
    }
}
