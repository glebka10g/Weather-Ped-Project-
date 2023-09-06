//
//  TimeAndDate.swift
//  Weather
//
//  Created by Gleb Gurev on 23.08.2023.
//

import Foundation
class TimeAndDate {
    var closure: ((String) -> Void)?
    let formatter = DateFormatter()
    let defaults = UserDefaults.standard
    func timeAndDate() {
        let date = Date()
        let formatter = DateFormatter()
        let ident = defaults.string(forKey: "time")
        formatter.timeZone = TimeZone(identifier: ident!)
        formatter.dateFormat = "dd MMM HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        let time = formatter.string(from: date)
        defaults.set(time, forKey: "time")
        print(time)
    }
    
}
