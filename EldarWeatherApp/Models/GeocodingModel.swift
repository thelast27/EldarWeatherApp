//
//  GeocodingModel.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import Foundation

struct Geolocation: Codable {
    var cityName: String?
    var lat: Double?
    var lon: Double?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, country
        case cityName = "name"
    }
}
