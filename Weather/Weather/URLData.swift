//
//  URLData.swift
//  Weather
//
//  Created by Gleb Gurev on 17.08.2023.
//

import UIKit

class URLData: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func urlTemp () {
        var temp = 0
        var closure: ((Int) -> Void?)
        let request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=55.755864&lon=37.617698&appid=39d77d94f6ad258bdd4de81917ddab12")!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let settings = try? JSONDecoder().decode(Weather.self, from: data) {
                let tempURL = settings.main.temp
                temp = Int(tempURL) - 273
                closure(temp)
            }
            
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
