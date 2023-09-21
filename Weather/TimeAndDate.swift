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
    private let cityes = Cityes()
    
    func timeAndDate() {
        let date = Date()
        let formatter = DateFormatter()
        let ident = cityes.timeLocal()
        formatter.timeZone = TimeZone(identifier: ident)
        formatter.dateFormat = "dd MMM HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        let time = formatter.string(from: date)
        defaults.set(time, forKey: "time")
    }
    
    func sunrise() -> String {
        let unixTime = defaults.string(forKey: "unixSunrise")
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime!)!)
        let ident = cityes.timeLocal()
        self.formatter.timeZone = TimeZone(identifier: ident)
        self.formatter.timeStyle = .short
        self.formatter.dateFormat = "HH:mm"
        self.formatter.locale = Locale(identifier: "ru_RU")
        let time = formatter.string(from: date)
        return time
    }
    
    func sunset() -> String {
        let unixTime = defaults.string(forKey: "unixSunset")
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime!)!)
        let ident = cityes.timeLocal()
        self.formatter.timeZone = TimeZone(identifier: ident)
        self.formatter.timeStyle = .short
        self.formatter.dateFormat = "HH:mm"
        self.formatter.locale = Locale(identifier: "ru_RU")
        let time = formatter.string(from: date)
        return time
    }
    
    
}
