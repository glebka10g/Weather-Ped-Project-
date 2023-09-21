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
    private let cityes = Cityes()
    private let DataUrl = testURL()
    private let imageSelection = SelectionImage()
    private let chooseCity = ChooseACityVC()
    private let timeAndDate = TimeAndDate()
    private let feels = UILabel()
    private let buttonSearch = UIButton(type: .custom)
    private let city = UILabel()
    private let textTemp = UILabel()
    private let timeDate = UILabel()
    private var weatherImageView: UIImageView?
    private let sunRiseSet = UIButton(type: .system)
    private let tenButton = UIButton(type: .system)
    private let tomorrow = UIButton(type: .system)
    private let backgroundImage = UIImage(named: "background")
    
    private let defaults = UserDefaults.standard
    
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
        city.textColor = UIColor.white
        city.font = Label.getFont()
        view.addSubview(city)
        if let nameCity = defaults.string(forKey: "city") {
            city.text = nameCity
        } else {
            city.text = "Выберите город"
        }
        city.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().inset(70)
            maker.left.equalToSuperview().inset(20)
        }
    }
    
    func tempText() {
        let _ = DataUrl.urlTemp()
        DataUrl.closureTemp = { value in
            DispatchQueue.main.async{
                self.textTemp.text = "\(value)°"
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
        DataUrl.closureFeels = { value in
            DispatchQueue.main.async {
                self.feels.text = "Ощущение \(value)°"
                
            }
        }
        feels.textColor = .white
        feels.font = .systemFont(ofSize: 18)
        view.addSubview(feels)
        
        feels.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(103)
            maker.top.equalToSuperview().inset(233)
        }
    }
    
    
    func image() {
        imageSelection.closureImage = { value in
            DispatchQueue.main.async{
                self.weatherImageView?.removeFromSuperview()
                let newImage = UIImage(named: value)
                let imageView = UIImageView(image: newImage)
                self.view.addSubview(imageView)
                imageView.snp.makeConstraints { maker in
                    maker.height.width.equalTo(107)
                    maker.top.equalToSuperview().inset(130)
                    maker.right.equalToSuperview().inset(28)
                }
                self.weatherImageView = imageView
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
        sunRiseSet.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        sunRiseSet.backgroundColor = .white
        sunRiseSet.layer.cornerRadius = config.cornerRadius
        sunRiseSet.setTitleColor(config.setTitleColor, for: .normal)
        sunRiseSet.setTitle("Сумерки", for: .normal)
        view.addSubview(sunRiseSet)
        sunRiseSet.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.top.equalToSuperview().inset(400)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
        }
        sunRiseSet.addTarget(self, action: #selector(sunButton), for: .touchUpInside)
    }
    
    func tomorrowButton(with config: buttonsDaysConfig) {
        tomorrow.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        tomorrow.backgroundColor = .white
        tomorrow.layer.cornerRadius = config.cornerRadius
        tomorrow.setTitleColor(config.setTitleColor, for: .normal)
        tomorrow.setTitle("Завтра", for: .normal)
        view.addSubview(tomorrow)
        tomorrow.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(139)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
            maker.top.equalToSuperview().inset(400)
        }
       
    }
    
    func tenDaysButton(with config: buttonsDaysConfig) {
        tenButton.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        tenButton.backgroundColor = .white
        tenButton.layer.cornerRadius = config.cornerRadius
        tenButton.setTitleColor(config.setTitleColor, for: .normal)
        tenButton.setTitle("10 Дней", for: .normal)
        view.addSubview(tenButton)
        tenButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(268)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
            maker.top.equalToSuperview().inset(400)
        }
    }
    
    func dayAndTime() {
        timeAndDate.timeAndDate()
        if let time = defaults.string(forKey: "time") {
            timeDate.text = time
        }
        
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
        let backgroundImage = UIImageView(image: backgroundImage)
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
        let image = UIImage(named: "search") ?? UIImage()
        buttonSearch.setImage(image, for: .normal)
        view.addSubview(buttonSearch)
        buttonSearch.imageView?.contentMode = .center
        buttonSearch.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(35)
            maker.right.equalToSuperview().inset(0)
            maker.height.width.equalTo(80)
        }
        
        buttonSearch.addTarget(self, action: #selector(newCity), for: .touchUpInside)
    }
    
    @objc private func newCity() {
        navigationController?.pushViewController(chooseCity, animated: true)
        
    }
    
    @objc private func sunButton() {
        tomorrow.backgroundColor = .white
        tenButton.backgroundColor = .white
        sunRiseSet.backgroundColor = buttonsDaysConfig.button.background
        
        let sunriseLabel = UILabel()
        let buttonSunset = UIButton(type: .system)
        buttonSunset.layer.cornerRadius = 10
        sunriseLabel.numberOfLines = 2
        sunriseLabel.layer.masksToBounds = true
        sunriseLabel.layer.cornerRadius = 10
        
        DataUrl.urlTemp()
            DataUrl.closureSunrise = { value in
                DispatchQueue.main.async {
                    sunriseLabel.text = "Рассвет \n \(value)"
                    sunriseLabel.textAlignment = .center
            } }
        DataUrl.closureSunset = { value in
            DispatchQueue.main.async {
                buttonSunset.setTitle("Закат в \(value)", for: .normal)
            }
            
        }
        buttonSunset.titleLabel?.font = .systemFont(ofSize: 23)
        sunriseLabel.font = .systemFont(ofSize: 23)
        buttonSunset.setTitleColor(.black, for: .normal)
        sunriseLabel.textColor = .black
        sunriseLabel.backgroundColor = UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)
        buttonSunset.backgroundColor = UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)
        view.addSubview(sunriseLabel)
        view.addSubview(buttonSunset)
        sunriseLabel.snp.makeConstraints { maker in
            maker.top.equalTo(sunRiseSet).inset(65)
            maker.width.equalTo(182)
            maker.height.equalTo(65)
            maker.left.equalToSuperview().inset(15)
        }
        buttonSunset.snp.makeConstraints { maker in
            maker.width.equalTo(282)
            maker.height.equalTo(65)
            maker.bottom.equalToSuperview().inset(100)
            maker.left.equalToSuperview().inset(30)
        }
    }
}

extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        changeNameCity()
        DataUrl.urlTemp()
        changeTimeAndDate()
        image()
        
    }
    func changeNameCity() {
        self.chooseCity.closureCity = { value in
            self.city.text = value
        }
    }
    func changeTimeAndDate() {
        timeAndDate.timeAndDate()
        if let time = defaults.string(forKey: "time") {
            timeDate.text = time
        }
    }
}

