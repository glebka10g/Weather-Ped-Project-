//
//  ImageSelection.swift
//  Weather
//
//  Created by Gleb Gurev on 25.07.2023.
//

import Foundation
import UIKit


class SelectionImage {
    private let dataURL = testURL()
    
    var closureImage: ((String) -> Void)?
    var closureText: ((String) -> Void)?
    func testPogoda() {
        let _ = dataURL.urlTemp()
        
        DispatchQueue.main.async {
            self.dataURL.closureObl = { value in

                print(value)
                switch value {
                case "Clear":
                    self.closureImage?("Sun")
                    self.closureText?("Солнечно")
                case "Clouds":
                    self.closureImage?("Cloud")
                    self.closureText?("Облачно")
                case "Rain":
                    self.closureImage?("Rain")
                    self.closureText?("Дождь")
                default:
                    self.closureImage?("Storm")
                    self.closureText?("Дождь с грозой")
                }
            }
        }
    }
    
}
