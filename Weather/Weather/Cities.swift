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
    let cityRussia = ["Самара":["Europe/Samara": [53.2, 50.11]], "Москва":["Europe/Moscow": [55.7522, 37.6156]], "Казань":["Europe/Moscow": [55.7887, 49.1221]], "Владивосток":["Asia/Vladivostok": [43.1056, 131.8735]], "Санкт-Петербург":["Europe/Moscow": [59.8944,30.2642]]]
    
    
    func latLon(_ city: String) {
        if self.cityRussia[city] != nil {
                    if let latLon = self.cityRussia[city]?.values.flatMap({$0}) {
                        ud.setValue(latLon, forKey: "latLon")
                    }
            if let time = self.cityRussia[city]?.keys {
                ud.set(time.joined(), forKey: "time")
            }
        }
    }
}
