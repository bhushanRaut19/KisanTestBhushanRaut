//
//  weatherModel.swift
//  Bhushan_Raut_Test
//
//  Created by iT Gurus Software on 22/01/19.
//  Copyright © 2019 Bhushan Raut. All rights reserved.
//

import Foundation

typealias WeatherArray = [WeatherElement]

struct WeatherElement: Codable {
    let value: Double?
    let year, month: Int?
}
