//
//  ViewController.swift
//  Weather
//
//  Created by Gleb Gurev on 04.07.2023.
//

import UIKit
import SnapKit

enum ButtonsDaysConfig {
    case button
    var background: UIColor { return UIColor(red: 225/255, green: 182/255, blue: 255/255, alpha: 1) }
    var font: CGFloat { return 16 }
    var cornerRadius: CGFloat { return 20 }
    var setTitleColor: UIColor { return .black }
    var heightConstraint: Int { return 50}
    var widthConstraint: Int { return 116}
}

enum LabelConfig {
    case label
    var activeBackgroundColor: UIColor {return UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)}
    var font: CGFloat { return 23 }
    var cornerRadius: CGFloat { return 15 }
    var passiveBackgroundColor: UIColor { return .white }
    var colorText: UIColor { return .black }
}

enum SunriseSetCinfig {
    case image
    var heightAndWidth: CGFloat { return 130 }
    var top : CGFloat { return 50 }
    var leftRight: CGFloat { return 30 }
    
}
//enum labelConfig {
//    case label
//    var numberOfLines: CGFloat { return 2 }
//    var font: CGFloat { return 23 }
//    var colorFont: UIColor { return .black }
//    var cornerRadius: CGFloat { return 15}
//    var background: UIColor { return UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1) }
//}


class ViewController: UIViewController {
    private var windImageView: UIImageView?
    private var pressureImageView: UIImageView?
    private var humidityImageView: UIImageView?
    private var sunriseImageView: UIImageView?
    private var sunsetImageView: UIImageView?
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
    private let toGo = UIButton(type: .system)
    private let weather = UIButton(type: .system)
    private let backgroundImage = UIImage(named: "background")
    private let sunriseLabel = UILabel()
    private let sunsetLabel = UILabel()
    private let humdityLabel = UILabel()
    private let pressureLabel = UILabel()
    private let windLabel = UILabel()
    
    private let defaults = UserDefaults.standard
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
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
        weatherButton(with: .button)
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
            city.text = "Москва"
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
    
    func toDayButton(with config: ButtonsDaysConfig) {
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
    
    func weatherButton(with config: ButtonsDaysConfig) {
        weather.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        weather.backgroundColor = .white
        weather.layer.cornerRadius = config.cornerRadius
        weather.setTitleColor(config.setTitleColor, for: .normal)
        weather.setTitle("Погода", for: .normal)
        view.addSubview(weather)
        weather.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(139)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
            maker.top.equalToSuperview().inset(400)
        }
        weather.addTarget(self, action: #selector(weatherTarget), for: .touchUpInside)
        
    }
    
    func tenDaysButton(with config: ButtonsDaysConfig) {
        toGo.titleLabel?.font = UIFont.systemFont(ofSize: config.font)
        toGo.backgroundColor = .white
        toGo.layer.cornerRadius = config.cornerRadius
        toGo.setTitleColor(config.setTitleColor, for: .normal)
        toGo.setTitle("Куда сходить", for: .normal)
        view.addSubview(toGo)
        toGo.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(268)
            maker.height.equalTo(config.heightConstraint)
            maker.width.equalTo(config.widthConstraint)
            maker.top.equalToSuperview().inset(400)
        }
        toGo.addTarget(self, action: #selector(toGoTarget), for: .touchUpInside)
    }
    
    func dayAndTime() {
        timeAndDate.timeAndDate()
        if let time = defaults.string(forKey: "time") {
            timeDate.text = time
            print("\(time)")
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
        deactivateAllButtons()
        sunRiseSet.backgroundColor = ButtonsDaysConfig.button.background
        сopyButtonSunrise()
        сopyButtonSunset()
        deactiveWeather()
    }
    
    private func createSunriseImageView() -> UIImageView {
        let sunriseImage = UIImage(named: "Sunrise")
        let imageView = UIImageView(image: sunriseImage)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.height.width.equalTo(SunriseSetCinfig.image.heightAndWidth)
            maker.top.equalTo(sunRiseSet).inset(SunriseSetCinfig.image.top)
            maker.left.equalToSuperview().inset(SunriseSetCinfig.image.leftRight)
        }
        sunriseImageView = imageView
        return imageView
    }
    
    private func deactivateAllButtons() {
        weather.backgroundColor = .white
        toGo.backgroundColor = .white
        sunRiseSet.backgroundColor = .white
    }
    
    private func displaySunriseLabel() -> UILabel {
        sunriseLabel.numberOfLines = 2
        sunriseLabel.layer.masksToBounds = true
        sunriseLabel.layer.cornerRadius = 15
        
        sunriseLabel.text = "Рассвет \n \(timeAndDate.sunrise())"
        
        sunriseLabel.textAlignment = .center
        
        sunriseLabel.font = .systemFont(ofSize: 23)
        sunriseLabel.textColor = .black
        sunriseLabel.backgroundColor = UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)
        view.addSubview(sunriseLabel)
        sunriseLabel.snp.makeConstraints { maker in
            maker.top.equalTo(createSunriseImageView()).inset(130)
            maker.width.equalTo(182)
            maker.height.equalTo(65)
            maker.left.equalToSuperview().inset(10)
        }
        return sunriseLabel
    }
    
    private func сopyButtonSunrise() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Скопировать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 23)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.top.equalTo(displaySunriseLabel()).inset(90)
            maker.left.equalToSuperview().inset(10)
            maker.width.equalTo(182)
            maker.height.equalTo(65)
        }
        button.addTarget(self, action: #selector(targetCopySunrise), for: .touchUpInside)
        return button
    }
    
    @objc private func targetCopySunrise() {
        let copy = UIPasteboard.general
        let timeSunrise = defaults.string(forKey: "sunriseDate")
        let city = defaults.string(forKey: "city")
        if let time = timeSunrise {
            copy.string = "Рассвет в городе '\(city ?? "Error")' начнется в \(time)"
        }
    }
    
    
    private func sunsetImage() -> UIImageView {
        let image = UIImage(named: "Sunset")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { maker in
            maker.height.width.equalTo(SunriseSetCinfig.image.heightAndWidth)
            maker.top.equalTo(sunRiseSet).inset(SunriseSetCinfig.image.top)
            maker.right.equalToSuperview().inset(SunriseSetCinfig.image.leftRight)
        }
        sunsetImageView = imageView
        return imageView
    }
    
    private func displaySunsetLabel() -> UILabel {
        sunsetLabel.numberOfLines = 2
        sunsetLabel.layer.masksToBounds = true
        sunsetLabel.layer.cornerRadius = 15
        
        sunsetLabel.text = "Закат \n \(timeAndDate.sunset())"
        sunsetLabel.textAlignment = .center
        
        
        sunsetLabel.font = .systemFont(ofSize: 23)
        sunsetLabel.textColor = .black
        sunsetLabel.backgroundColor = UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)
        view.addSubview(sunsetLabel)
        sunsetLabel.snp.makeConstraints { maker in
            maker.top.equalTo(sunsetImage()).inset(130)
            maker.width.equalTo(182)
            maker.height.equalTo(65)
            maker.right.equalToSuperview().inset(10)
        }
        return sunsetLabel
    }
    
    
    private func сopyButtonSunset() {
        let button = UIButton(type: .system)
        button.setTitle("Скопировать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 23)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.top.equalTo(displaySunsetLabel()).inset(90)
            maker.right.equalToSuperview().inset(10)
            maker.width.equalTo(182)
            maker.height.equalTo(65)
        }
        button.addTarget(self, action: #selector(targetCopySunset), for: .touchUpInside)
    }
    
    @objc private func targetCopySunset() {
        let copy = UIPasteboard.general
        let timeSunrise = defaults.string(forKey: "sunsetDate")
        let city = defaults.string(forKey: "city")
        if let time = timeSunrise {
            copy.string = "Закат в городе '\(city ?? "Error")' начнется в \(time)"
        }
    }
    
    //Target button 'Weather'
    @objc private func weatherTarget() {
        deactivateAllButtons()
        weather.backgroundColor = ButtonsDaysConfig.button.background
        
        for subview in view.subviews {
            if let button = subview as? UIButton, button.titleLabel?.text == "Скопировать" {
                button.removeFromSuperview()
            }
        }
        deactiveSunRiseSet()
        pressureDisplay()
        humidityDisplay()
        windDisplay()
    }
    
    private func humdityImageView() -> UIImageView {
        let humdityImage = UIImage(named: "Humidity")
        let imageView = UIImageView(image: humdityImage)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.height.width.equalTo(120)
            maker.top.equalTo(sunRiseSet).inset(SunriseSetCinfig.image.top)
            maker.left.equalToSuperview().inset(30)
        }
        humidityImageView = imageView
        return imageView
        
    }
    private func humidityDisplay() {
        humdityLabel.layer.masksToBounds = true
        humdityLabel.numberOfLines = 2
        humdityLabel.text = ("Влажность \n \(defaults.string(forKey: "humidity") ?? "error")%")
        humdityLabel.backgroundColor = UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)
        humdityLabel.textAlignment = .center
        humdityLabel.layer.cornerRadius = 15
        humdityLabel.font = .systemFont(ofSize: LabelConfig.label.font)
        view.addSubview(humdityLabel)
        humdityLabel.snp.makeConstraints { maker in
            maker.top.equalTo(humdityImageView()).inset(135)
            maker.width.equalTo(182)
            maker.height.equalTo(65)
            maker.left.equalToSuperview().inset(10)
        }
    }
    
    private func pressureImage() -> UIImageView {
        let image = UIImage(named: "Pressure")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.height.width.equalTo(120)
            maker.top.equalTo(sunRiseSet).inset(SunriseSetCinfig.image.top + 5 )
            maker.right.equalToSuperview().inset(30)
        }
        pressureImageView = imageView
        return imageView
    }
    
    private func pressureDisplay() {
        let pressureClass = Pressure()
        pressureLabel.numberOfLines = 2
        pressureLabel.layer.masksToBounds = true
        pressureLabel.textAlignment = .center
        pressureLabel.text = ("Давление \n\(String(pressureClass.convertion())) мм.рт.ст")
        pressureLabel.backgroundColor = UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)
        pressureLabel.textColor = .black
        pressureLabel.font = .systemFont(ofSize: LabelConfig.label.font)
        pressureLabel.layer.cornerRadius = 15
        view.addSubview(pressureLabel)
        pressureLabel.snp.makeConstraints { maker in
            maker.top.equalTo(pressureImage()).inset(130)
            maker.width.equalTo(182)
            maker.height.equalTo(65)
            maker.right.equalToSuperview().inset(10)
        }
    }
    
    private func windImage() -> UIImageView {
        let image = UIImage(named: "Wind")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.height.width.equalTo(85)
            maker.top.equalTo(pressureLabel).inset(90)
            maker.left.equalTo(10)
        }
        windImageView = imageView
        return imageView
    }
    
    private func windDisplay() {
        windLabel.text = ("Скорость ветра - \(self.defaults.string(forKey: "Wind") ?? "Error")")
        windLabel.layer.masksToBounds = true
        windLabel.layer.cornerRadius = 15
        view.addSubview(windLabel)
        windLabel.font = .systemFont(ofSize: 22)
        windLabel.backgroundColor = UIColor(red: 235/255, green: 223/255, blue: 255/255, alpha: 1)
        windLabel.textColor = .black
        windLabel.textAlignment = .center
        windLabel.snp.makeConstraints { maker in
            maker.left.equalTo(windImage()).inset(100)
            maker.top.equalTo(humdityLabel).inset(100)
            maker.right.equalToSuperview().inset(20)
            maker.height.equalTo(65)
        }
    }
    
    
    func deactiveSunRiseSet() {
        for subview in view.subviews {
            if let button = subview as? UIButton, button.titleLabel?.text == "Скопировать" {
                button.removeFromSuperview()
            }
            
            sunriseImageView?.removeFromSuperview()
            sunsetImageView?.removeFromSuperview()
            sunriseLabel.removeFromSuperview()
            sunsetLabel.removeFromSuperview()
        }
    }
    func deactiveWeather() {
        humidityImageView?.removeFromSuperview()
        humdityLabel.removeFromSuperview()
        
        pressureImageView?.removeFromSuperview()
        pressureLabel.removeFromSuperview()
        
        windImageView?.removeFromSuperview()
        windLabel.removeFromSuperview()
    }
    
    @objc private func toGoTarget() {
        deactivateAllButtons()
        deactiveWeather()
        deactiveSunRiseSet()
        let testVC = testTableView()
        navigationController?.pushViewController(testVC, animated: false)
    }
}

extension ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        changeNameCity()
        DataUrl.urlTemp()
        changeTimeAndDate()
        changeHumidity()
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
    
    override func viewDidAppear(_ animated: Bool) {
        if sunRiseSet.backgroundColor == ButtonsDaysConfig.button.background {
            changeSunriseText()
            changeSunsetText()
        }
        if weather.backgroundColor == ButtonsDaysConfig.button.background {
            changeHumidity()
            changePessure()
            changeWind()
        }
    }
    
    private func changeWind() {
        windLabel.text = ("Скорость ветра - \(self.defaults.string(forKey: "Wind") ?? "Error")")
    }
    
    func changePessure() {
        let pressure = Pressure()
        pressureLabel.text = ("Давление \n\(String(pressure.convertion())) мм.рт.ст")
    }
    func changeHumidity() {
        if let text = self.defaults.string(forKey: "humidity") {
            self.humdityLabel.text = ("Влажность \n \(text)%")
        }
    }
    func changeSunriseText() {
        sunriseLabel.text = "Рассвет \n \(timeAndDate.sunrise())"
        defaults.set(timeAndDate.sunrise(), forKey: "sunriseDate")
    }
    func changeSunsetText() {
        sunsetLabel.text = "Закат \n \(timeAndDate.sunset())"
        defaults.set("\(timeAndDate.sunset())", forKey: "sunsetDate")
    }
}
