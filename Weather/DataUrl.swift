//
//  DataURL.swift
//  Weather
//
//  Created by Gleb Gurev on 17.08.2023.
//

import Foundation

class testURL {
    var closureTemp: ((String) -> Void)?
    var closureMaxTemp: ((String) -> Void)?
    var closureMinTemp: ((String) -> Void)?
    var closureObl: ((String) -> Void)?
    var closureFeels: ((String) -> Void)?
    var closureSunrise: ((String) -> Void)?
    var closureSunset: ((String) -> Void)?
    var closureHumidity: ((Int) -> Void)?
    
    private let defaults = UserDefaults.standard
    private let timeAndDate = TimeAndDate()
    
    private var latLon: [Double] = [55.7522,37.6156]
    private let formatter = DateFormatter()
    
    func urlTemp() {
        if let defaults = defaults.array(forKey: "latLon") as? [Double]{
                latLon = defaults
        }
        let request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latLon[0])&lon=\(latLon[1])&appid=39d77d94f6ad258bdd4de81917ddab12")!)
        let taskTemp = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let settings = try? JSONDecoder().decode(Weather.self, from: data) {
                let tempURL = settings.main.temp
                let temp = String(Int(tempURL - 273))
                self.closureTemp?(temp)
                
                let tempFeels = settings.main.feelsLike
                let feels = String((Int(tempFeels - 273)))
                self.closureFeels?(feels)
                
                let maxTemp = settings.main.tempMax
                let max = String(Int(maxTemp - 273))
                self.closureMaxTemp?(max)
                
                let mintemp = settings.main.tempMin
                let min = String(Int(mintemp - 273))
                self.closureMinTemp?(min)
                
                let oblURL = settings.weather.first?.main
                self.closureObl?(oblURL ?? "Error")
                
                let sunrise = settings.sys.sunrise
                self.defaults.set(sunrise, forKey: "unixSunrise")
                let sunset = settings.sys.sunset
                self.defaults.set(sunset, forKey: "unixSunset")
                
                let humidity = settings.main.humidity
                self.defaults.set(humidity, forKey: "humidity")
                
                let pressure = settings.main.pressure
                self.defaults.set(pressure, forKey: "pressureConv")
                
                let wind = settings.wind.speed
                self.defaults.set(wind, forKey: "Wind")
            }
        }
        taskTemp.resume()
    }
}
