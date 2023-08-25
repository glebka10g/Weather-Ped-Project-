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
    func urlTemp() {
        let request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=55.755864&lon=37.617698&appid=39d77d94f6ad258bdd4de81917ddab12")!)
        
        let taskTemp = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let settings = try? JSONDecoder().decode(Weather.self, from: data) {
                let tempURL = settings.main.temp
                let test = String(Int(tempURL - 273))
                self.closureTemp?(test)
                
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
                
            }
        }
        taskTemp.resume()
    }
}
