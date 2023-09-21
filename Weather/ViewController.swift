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
    private let sunriseLabel = UILabel()
    private let sunsetLabel = UILabel()
    
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
    
    func tomorrowButton(with config: ButtonsDaysConfig) {
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
    
    func tenDaysButton(with config: ButtonsDaysConfig) {
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
    }
    
    private func createSunriseImageView() -> UIImageView {
        let sunriseImage = UIImage(named: "Sunrise")
        let sunriseImageView = UIImageView(image: sunriseImage)
        
        view.addSubview(sunriseImageView)
        sunriseImageView.snp.makeConstraints { maker in
            maker.height.width.equalTo(SunriseSetCinfig.image.heightAndWidth)
            maker.top.equalTo(sunRiseSet).inset(SunriseSetCinfig.image.top)
            maker.left.equalToSuperview().inset(SunriseSetCinfig.image.leftRight)
        }
        
        return sunriseImageView
    }
    
    private func deactivateAllButtons() {
        tomorrow.backgroundColor = .white
        tenButton.backgroundColor = .white
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
    
    private func сopyButtonSunrise() {
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
    
    override func viewDidAppear(_ animated: Bool) {
        changeSunriseText()
        changeSunsetText()
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
