//
//  Pressure.swift
//  Weather
//
//  Created by Gleb Gurev on 27.09.2023.
//

import Foundation

class Pressure {
    let defaults = UserDefaults.standard
    let dataURl = testURL()
    func convertion() -> Int {
        dataURl.urlTemp()
        if let pressure = defaults.string(forKey: "pressureConv") {
            return Int(Double(pressure)! * 0.75)
        }
        return -1
    }
}
