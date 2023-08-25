//
//  TimeAndDate.swift
//  Weather
//
//  Created by Gleb Gurev on 23.08.2023.
//

import Foundation
class TimeAndDate {
    var closure: ((String) -> Void)?
    
    func timeAndDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Europe/Moscow")
        formatter.dateFormat = "dd MMM HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        let new = formatter.string(from: date)
        closure?(new)
        
        
    }
    
}
