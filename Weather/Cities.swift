//
//  Cities.swift
//  Weather
//
//  Created by Gleb Gurev on 28.08.2023.
//

import Foundation

class Cityes {
    let ud = UserDefaults.standard
    var closureLatLon: (([Double]) -> Void)?
    var timeAndDataCity: ((String) -> Void)?
    let cityRussia = ["Самара":["Europe/Samara": [53.2, 50.11]], "Москва":["Europe/Moscow": [55.7522, 37.6156]], "Казань":["Europe/Moscow": [55.7887, 49.1221]], "Владивосток":["Asia/Vladivostok": [43.1056, 131.8735]], "Сочи":["Europe/Moscow": [43.6, 39.7303]], "Калининград":["Europe/Kaliningrad": [54.7065, 20.511]], "Оренбург":["Europe/Orenburg": [51.7727, 55.0988]], "Красноярск":["Asia/Krasnoyarsk": [56.0097, 92.7917]]]
    
    
    func latLon(_ city: String) {
        if self.cityRussia[city] != nil {
            if let latLon = self.cityRussia[city]?.values.flatMap({$0}) {
                ud.setValue(latLon, forKey: "latLon")
            }
        }
    }
        
    func timeLocal() -> String {
                return (cityRussia[ud.string(forKey: "city")!]?.keys.joined())!
        }
        
    }
