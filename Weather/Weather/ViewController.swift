//
//  ViewController.swift
//  Weather
//
//  Created by Gleb Gurev on 04.07.2023.
//

import UIKit
import SnapKit

enum buttonsDaysConfig {
    case button
    var background: UIColor { return UIColor(red: 225/255, green: 182/255, blue: 255/255, alpha: 1) }
    var font: CGFloat { return 16 }
    var cornerRadius: CGFloat { return 20 }
    var setTitleColor: UIColor { return .black }
    var heightConstraint: Int { return 50}
    var widthConstraint: Int { return 116}
}



class ViewController: UIViewController {
    
    private let DataUrl = testURL()
    private let imageSelection = SelectionImage()
    
    
    struct Label {
        var name: String
        var textColor: UIColor
        var font: UIFont


        static func getTextColor() -> UIColor {
            return UIColor.black
        }

        static func getFont() -> UIFont {
            return UIFont.boldSystemFont(ofSize: 26)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 247/255, green: 237/255, blue: 255/255, alpha: 1)
        labelCity()
        textObl()
        image()
        tempText()
        feelsLike()
        toDayButton(with: .button)
        tomorrowButton(with: .button)
        tenDaysButton(with: .button)
        dayAndTime()
        maxTemp()
        minTemp()
        backgroundUP()
        search()
    }
    
    func labelCity() {
        let city = UILabel()
        city.textColor = UIColor.white
        city.font = Label.getFont()
        view.addSubview(city)
        city.text = "Москва"
        city.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().inset(20)
            maker.height.width.equalTo(100)
        }
    }
    
    func tempText() {
        let textTemp = UILabel()
        let _ = DataUrl.urlTemp()
        DataUrl.closureTemp = { value in
            DispatchQueue.main.async{
                textTemp.text = "\(value)°"
            }
        }
        textTemp.textColor = .white
        view.addSubview(textTemp)
        textTemp.font = .boldSystemFont(ofSize: 84)
        textTemp.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(5)
            maker.top.equalToSuperview().inset(170)
        }
    }
    
    func feelsLike() {
        let feels = UILabel()
            DataUrl.closureFeels = { value in
                DispatchQueue.main.async {
                feels.text = "Ощущение \(value)°"
                print(value)
            }
        }
        feels.textColor = .white
        feels.font = .systemFont(ofSize: 18)
        view.addSubview(feels)
        
        feels.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(100)
            maker.top.equalToSuperview().inset(230)
        }
    }
    
    
    func image() {
        imageSelection.closureImage = { value in
           DispatchQueue.main.async{
                print(value)
                let newImage = UIImage(named: value)
                let imageView = UIImageView(image: newImage)
                self.view.addSubview(imageView)
                imageView.snp.makeConstraints { maker in
                    maker.height.width.equalTo(107)
                    maker.top.equalToSuperview().inset(130)
                    maker.right.equalToSuperview().inset(28)
                }
            }
        }
        imageSelection.testPogoda()
    }
    
    func textObl() {
        let textObl = UILabel()
        
        
        imageSelection.closureText = { value in
            DispatchQueue.main.async {
                textObl.text = value
            }
        }
        
        imageSelection.testPogoda()
       
        textObl.font = .systemFont(ofSize: 22)
        textObl.textColor = .white
        view.addSubview(textObl)
        
        textObl.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(250)
            maker.right.equalToSuperview().inset(37)
        }
    }
    
    func toDayButton(with config: buttonsDaysConfig) {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        button.backgroundColor = config.background
        button.layer.cornerRadius = config.cornerRadius
        button.setTitleColor(config.setTitleColor, for: .normal)
        button.setTitle("Сегодня", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.top.equalToSuperview().inset(400)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
        }
    }
    
    func tomorrowButton(with config: buttonsDaysConfig) {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        button.backgroundColor = .white
        button.layer.cornerRadius = config.cornerRadius
        button.setTitleColor(config.setTitleColor, for: .normal)
        button.setTitle("Завтра", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(139)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
            maker.top.equalToSuperview().inset(400)
        }
    }
    
    func tenDaysButton(with config: buttonsDaysConfig) {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        button.backgroundColor = .white
        button.layer.cornerRadius = config.cornerRadius
        button.setTitleColor(config.setTitleColor, for: .normal)
        button.setTitle("10 Дней", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(268)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
            maker.top.equalToSuperview().inset(400)
        }
    }
    
    func dayAndTime() {
        let timeDate = UILabel()
        let timeAndDate = TimeAndDate()
        
            timeAndDate.closure = { value in
                    timeDate.text = "\(value)"
                    print(value)
        }
        timeAndDate.timeAndDate()
        
        timeDate.textColor = .white
        timeDate.font = .systemFont(ofSize: 18)
        view.addSubview(timeDate)
        timeDate.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(355)
            maker.left.equalToSuperview().inset(17)
        }
    }
    
    func maxTemp() {
        let maxTemp = UILabel()
        
        DataUrl.closureMaxTemp = { value in
            DispatchQueue.main.async {
                maxTemp.text = "Днем - \(value)"
            }
        }
        DataUrl.urlTemp()
        maxTemp.font = UIFont.boldSystemFont(ofSize: 18)
        maxTemp.textColor = .white
        view.addSubview(maxTemp)
        
        maxTemp.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(333)
            maker.right.equalToSuperview().inset(10)
        }
    }
    
    func minTemp() {
        let maxTemp = UILabel()
        
        DataUrl.closureMinTemp = { value in
            DispatchQueue.main.async {
                maxTemp.text = "Ночью - \(value)"
            }
        }
        DataUrl.urlTemp()
        maxTemp.font = UIFont.boldSystemFont(ofSize: 18)
        maxTemp.textColor = .white
        view.addSubview(maxTemp)
        
        maxTemp.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(355)
            maker.right.equalToSuperview().inset(10)
        }
    }
    
    func backgroundUP () {
        let image = UIImage(named: "background")
        let backgroundImage = UIImageView(image: image)
        backgroundImage.layer.masksToBounds = true
        backgroundImage.layer.cornerRadius = 25
        view.insertSubview(backgroundImage, at: 0)
        backgroundImage.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(0)
            maker.height.equalToSuperview().inset(230)
            maker.width.equalToSuperview()
        }
    }
    
    func search() {
        let image = UIImage(named: "search")
        let buttonSearch = UIButton(type: .custom)
        buttonSearch.setImage(image, for: .normal)
        view.addSubview(buttonSearch)
        
        buttonSearch.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(55)
            maker.right.equalToSuperview().inset(20)
            maker.height.width.equalTo(30)
        }
    }
}
 

